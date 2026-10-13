(function(){
  const db=()=>window.zhixuSupabase;
  function esc(v){return String(v==null?'':v).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
  function date(v){if(!v)return '';const d=new Date(v);return isNaN(d)?String(v).slice(0,10):d.toLocaleDateString('zh-CN',{year:'numeric',month:'short',day:'numeric'});}
  function toCard(a){return {id:a.id,slug:a.slug,title:a.title||'无标题',excerpt:a.summary||'',category:a.category||'未分类',tags:Array.isArray(a.tags)?a.tags:[],date:date(a.published_at||a.updated_at||a.created_at),status:a.status,content:a.content||''};}
  async function published(){const {data,error}=await db().from('articles').select('id,slug,title,summary,content,category,tags,status,created_at,updated_at,published_at').eq('status','published').order('published_at',{ascending:false,nullsFirst:false});if(error)throw error;return (data||[]).map(toCard);}
  window.Zhixu={db,esc,date,toCard,published};
})();
