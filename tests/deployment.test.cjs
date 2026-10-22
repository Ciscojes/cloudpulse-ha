const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, '..', 'deployment.js'), 'utf8');
async function scenario(identity, healthy = true) {
  const elements = new Map();
  for (const name of ['deployment-status','check-server','real-id','real-zone','real-time','real-health','web-badge']) {
    elements.set(name, {textContent:'',disabled:false,dataset:{},addEventListener(_,fn){this.click=fn;}});
  }
  const calls=[];
  vm.runInNewContext(source, {
    document:{getElementById:name=>elements.get(name)},
    fetch:async(url,options)=>{
      calls.push({url,options});
      return url.includes('identity.json') ? {ok:!!identity,json:async()=>identity} :
        {ok:healthy,status:healthy?200:503,text:async()=>healthy?'ok':'unavailable'};
    }, Date,AbortSignal,
  });
  await new Promise(resolve=>setImmediate(resolve));
  return {elements,calls};
}
(async()=>{
  const value={instanceId:'i-0123456789abcdef0',availabilityZone:'eu-west-1a'};
  const live=await scenario(value);
  assert.equal(live.elements.get('real-id').textContent,value.instanceId);
  assert.equal(live.elements.get('real-health').textContent,'HTTP 200 · ok');
  assert.equal(live.elements.get('web-badge').textContent,'Web accesible');
  assert(live.calls.every(call=>call.options.cache==='no-store'));
  const missing=await scenario(null,false);
  assert.equal(missing.elements.get('real-id').textContent,'Sin verificar');
  assert.equal(missing.elements.get('web-badge').textContent,'Comprobación fallida');
  const partial=await scenario(value,false);
  assert.equal(partial.elements.get('real-id').textContent,value.instanceId);
  assert.equal(partial.elements.get('real-health').textContent,'Sin respuesta válida');
  const invalid=await scenario({instanceId:'<img src=x>',availabilityZone:'eu-west-1a'});
  assert.equal(invalid.elements.get('real-id').textContent,'Sin verificar');
  await live.elements.get('check-server').click();
  assert.equal(live.calls.length,4);
  assert.equal(live.elements.get('check-server').disabled,false);
  const html=fs.readFileSync(path.join(__dirname,'..','index.html'),'utf8');
  assert(!/simulaci[oó]n|capacidad deseada|reemplazos|script\.js/i.test(html));
  console.log('PASS: datos válidos, errores, comprobación parcial, rechazo de datos inválidos y ausencia de simulación.');
})().catch(error=>{console.error(error);process.exitCode=1;});
