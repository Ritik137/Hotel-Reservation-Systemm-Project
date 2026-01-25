<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>

<style>
:root{
  --bg1:#020617;
  --bg2:#0b1220;
  --card:#0f1b2b;
  --border:#20324f;
  --text:#e5e7eb;
  --muted:#94a3b8;
  --success:#22c55e;
  --accent:#7c3aed;
}

*{box-sizing:border-box}

body{
  margin:0;
  min-height:100vh;
  display:grid;
  place-items:center;
  font-family:system-ui,Segoe UI,Arial;
  color:var(--text);
  background:
    radial-gradient(900px 500px at 10% 10%, rgba(34,197,94,.18), transparent 60%),
    radial-gradient(800px 500px at 90% 20%, rgba(124,58,237,.22), transparent 60%),
    linear-gradient(180deg,var(--bg1),var(--bg2));
}

/* floating glow */
.glow{
  position:fixed;
  width:420px;height:420px;
  border-radius:50%;
  background:rgba(34,197,94,.35);
  filter:blur(90px);
  top:-120px;left:-120px;
  animation: float 8s ease-in-out infinite;
}
@keyframes float{
  0%,100%{transform:translate(0,0)}
  50%{transform:translate(30px,20px)}
}

/* card */
.card{
  width:min(520px,92vw);
  background:linear-gradient(180deg,rgba(15,27,43,.9),rgba(15,27,43,.75));
  border:1px solid var(--border);
  border-radius:18px;
  box-shadow:0 30px 80px rgba(0,0,0,.55);
  padding:28px 24px 26px;
  text-align:center;
  animation: pop .7s cubic-bezier(.2,.9,.2,1);
}

@keyframes pop{
  from{opacity:0;transform:translateY(18px) scale(.96)}
  to{opacity:1;transform:translateY(0) scale(1)}
}

/* icon */
.icon{
  width:72px;height:72px;
  border-radius:50%;
  display:grid;
  place-items:center;
  margin:0 auto 14px;
  background:linear-gradient(135deg,#22c55e,#16a34a);
  box-shadow:0 0 0 8px rgba(34,197,94,.15);
  font-size:34px;
  animation: pulse 1.6s ease-in-out infinite;
}
@keyframes pulse{
  0%,100%{transform:scale(1)}
  50%{transform:scale(1.08)}
}

h2{
  margin:0;
  font-size:26px;
  letter-spacing:.3px;
}

p{
  margin:10px 0 0;
  color:var(--muted);
  font-size:14px;
}

/* buttons */
.actions{
  display:flex;
  gap:12px;
  margin-top:18px;
}

a{
  flex:1;
  text-decoration:none;
  padding:12px 14px;
  border-radius:12px;
  font-weight:700;
  transition:.18s ease;
}

.btn-primary{
  background:linear-gradient(135deg,var(--accent),#2563eb);
  color:#fff;
  box-shadow:0 14px 30px rgba(124,58,237,.3);
}
.btn-primary:hover{
  transform:translateY(-1px);
  box-shadow:0 18px 40px rgba(124,58,237,.4);
}

.btn-ghost{
  background:rgba(2,6,23,.35);
  border:1px solid var(--border);
  color:#c7d2fe;
}
.btn-ghost:hover{
  transform:translateY(-1px);
  filter:brightness(1.1);
}
</style>
</head>

<body>
<div class="glow"></div>

<div class="card">
  <div class="icon">✔</div>

  <h2>Saved Successfully!</h2>
  <p>Reservation has been added to the database.</p>

  <p style="margin-top:6px">
    Rows inserted: <b style="color:#22c55e">${rows}</b>
  </p>

  <div class="actions">
    <a class="btn-ghost" href="reservation-form.jsp">Add More</a>
    <a class="btn-primary" href="<%= request.getContextPath() %>/reservation/list">View List</a>
  </div>
</div>
</body>
</html>
