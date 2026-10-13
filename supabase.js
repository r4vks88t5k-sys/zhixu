/* 知序 Supabase 公共客户端。Publishable key 可用于浏览器；禁止放入 secret/service_role key。 */
(function () {
  const SUPABASE_URL = "https://sygtbsegyrxnchklbhnq.supabase.co";
  const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_1WxppvQVpesYG9ZfiyxKbg_0tZXEa79";
  if (!window.supabase || !window.supabase.createClient) {
    console.error('Supabase SDK 未加载。请检查网络连接或 CDN。');
    return;
  }
  window.zhixuSupabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true }
  });
})();
