<%@ page import="hotel.model.Reservation" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Reservation</title>

  <style>
    :root{
      --bg1:#0b1220;
      --bg2:#0f172a;
      --card: rgba(17, 24, 39, .72);
      --stroke: rgba(148, 163, 184, .18);
      --text:#e5e7eb;
      --muted:#94a3b8;
      --accent:#7c3aed;
      --accent2:#22c55e;
      --danger:#ef4444;
      --shadow: 0 24px 70px rgba(0,0,0,.45);
      --radius: 18px;
    }

    *{ box-sizing:border-box; }
    body{
      margin:0;
      min-height:100vh;
      display:grid;
      place-items:center;
      font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial;
      color:var(--text);
      background:
        radial-gradient(900px 600px at 15% 10%, rgba(124,58,237,.26), transparent 55%),
        radial-gradient(900px 600px at 90% 25%, rgba(34,197,94,.18), transparent 55%),
        radial-gradient(900px 600px at 50% 90%, rgba(59,130,246,.16), transparent 55%),
        linear-gradient(180deg, var(--bg1), var(--bg2));
      overflow-x:hidden;
      padding: 18px;
    }

    /* floating blobs */
    .blob{
      position:fixed;
      width:420px; height:420px;
      border-radius:50%;
      filter: blur(42px);
      opacity:.22;
      z-index:-1;
      animation: float 10s ease-in-out infinite;
    }
    .blob.one{ left:-140px; top:-120px; background:rgba(124,58,237,.95); }
    .blob.two{ right:-160px; top:120px; background:rgba(34,197,94,.9); animation-duration: 12s; }
    .blob.three{ left:30%; bottom:-190px; background:rgba(59,130,246,.9); animation-duration: 14s; }

    @keyframes float{
      0%,100%{ transform: translateY(0) translateX(0) scale(1); }
      50%{ transform: translateY(-18px) translateX(14px) scale(1.06); }
    }

    .wrap{
      width:min(900px, 96vw);
      display:grid;
      grid-template-columns: 1fr;
      gap: 14px;
      animation: popIn .75s cubic-bezier(.2,.9,.2,1) both;
    }
    @keyframes popIn{
      from{ opacity:0; transform: translateY(16px) scale(.98); }
      to{ opacity:1; transform: translateY(0) scale(1); }
    }

    .card{
      background: linear-gradient(180deg, rgba(17,24,39,.78), rgba(17,24,39,.55));
      border: 1px solid var(--stroke);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      backdrop-filter: blur(10px);
      overflow:hidden;
      position:relative;
    }

    .header{
      padding: 18px 18px 12px;
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      border-bottom: 1px solid rgba(148,163,184,.12);
    }

    .title{
      display:flex;
      align-items:center;
      gap:12px;
      min-width: 0;
    }

    .icon{
      width:44px;height:44px;
      border-radius: 14px;
      display:grid;
      place-items:center;
      font-size: 18px;
      background:
        radial-gradient(circle at 30% 30%, rgba(255,255,255,.35), transparent 55%),
        linear-gradient(135deg, var(--accent), #2563eb);
      box-shadow: 0 14px 30px rgba(124,58,237,.25);
      position:relative;
      overflow:hidden;
      flex:0 0 auto;
    }
    .icon::after{
      content:"";
      position:absolute;
      inset:-40%;
      background: linear-gradient(120deg, transparent 35%, rgba(255,255,255,.35), transparent 65%);
      transform: translateX(-35%) rotate(18deg);
      animation: shine 2.6s ease-in-out infinite;
      opacity:.7;
    }
    @keyframes shine{
      0%{ transform: translateX(-45%) rotate(18deg); opacity:.0; }
      30%{ opacity:.75; }
      100%{ transform: translateX(45%) rotate(18deg); opacity:0; }
    }

    h2{
      margin:0;
      font-size: 22px;
      letter-spacing:.2px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .sub{
      margin:4px 0 0;
      font-size: 13px;
      color: var(--muted);
    }

    .badge{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding: 8px 10px;
      border-radius: 999px;
      border: 1px solid rgba(148,163,184,.18);
      background: rgba(2,6,23,.25);
      font-size: 12px;
      color: rgba(229,231,235,.9);
      white-space:nowrap;
    }
    .dot{
      width:8px;height:8px;border-radius:50%;
      background: var(--accent2);
      box-shadow: 0 0 0 4px rgba(34,197,94,.14);
      animation: pulse 1.6s ease-in-out infinite;
    }
    @keyframes pulse{
      0%,100%{ transform: scale(1); opacity:.9; }
      50%{ transform: scale(1.35); opacity:1; }
    }

    .content{
      padding: 16px 18px 18px;
    }

    form{
      display:grid;
      gap: 14px;
    }

    .grid{
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }

    .field{ position:relative; }

    label{
      display:block;
      font-size: 12px;
      color: rgba(229,231,235,.85);
      margin: 0 0 6px;
      letter-spacing:.25px;
    }

    input{
      width:100%;
      padding: 12px 12px 12px 42px;
      border-radius: 12px;
      border: 1px solid rgba(148,163,184,.18);
      background: rgba(2,6,23,.25);
      color: var(--text);
      outline:none;
      transition: transform .2s ease, border-color .2s ease, box-shadow .2s ease, background .2s ease;
    }
    input:focus{
      border-color: rgba(124,58,237,.85);
      box-shadow: 0 0 0 4px rgba(124,58,237,.18);
      background: rgba(2,6,23,.35);
      transform: translateY(-1px);
    }

    .mini-ic{
      position:absolute;
      left:12px;
      top: 32px;
      width:22px;height:22px;
      border-radius: 10px;
      display:grid;
      place-items:center;
      background: rgba(124,58,237,.12);
      border: 1px solid rgba(124,58,237,.22);
      color: rgba(229,231,235,.9);
      font-size: 12px;
      pointer-events:none;
      transition: transform .2s ease, background .2s ease;
    }
    .field:focus-within .mini-ic{
      transform: translateY(-1px) scale(1.06);
      background: rgba(124,58,237,.18);
    }

    .actions{
      display:flex;
      gap: 12px;
      align-items:center;
      margin-top: 4px;
    }

    button{
      border:none;
      cursor:pointer;
      padding: 12px 14px;
      border-radius: 12px;
      font-weight: 800;
      letter-spacing:.2px;
      transition: transform .18s ease, box-shadow .18s ease, filter .18s ease;
      will-change: transform;
    }

    .btn-primary{
      flex:1;
      color:#fff;
      background: linear-gradient(135deg, var(--accent), #2563eb);
      box-shadow: 0 16px 34px rgba(124,58,237,.22);
      position:relative;
      overflow:hidden;
    }
    .btn-primary::after{
      content:"";
      position:absolute;
      inset:-40%;
      background: linear-gradient(120deg, transparent 35%, rgba(255,255,255,.35), transparent 65%);
      transform: translateX(-35%) rotate(18deg);
      opacity:0;
    }
    .btn-primary:hover{
      transform: translateY(-1px);
      box-shadow: 0 20px 46px rgba(124,58,237,.28);
    }
    .btn-primary:hover::after{
      opacity:1;
      animation: btnShine 1.2s ease;
    }
    @keyframes btnShine{
      0%{ transform: translateX(-45%) rotate(18deg); }
      100%{ transform: translateX(45%) rotate(18deg); }
    }

    .btn-ghost{
      color: rgba(229,231,235,.9);
      background: rgba(2,6,23,.25);
      border:1px solid rgba(148,163,184,.18);
    }
    .btn-ghost:hover{
      transform: translateY(-1px);
      filter: brightness(1.08);
    }

    .footer{
      padding: 12px 18px 16px;
      border-top: 1px solid rgba(148,163,184,.12);
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
      flex-wrap:wrap;
    }

    .link{
      color: rgba(165,180,252,.95);
      text-decoration:none;
      border-bottom: 1px dashed rgba(165,180,252,.4);
      padding-bottom: 2px;
      transition: filter .15s ease, transform .15s ease;
    }
    .link:hover{
      filter: brightness(1.15);
      transform: translateY(-1px);
    }

    .hint{
      color: rgba(148,163,184,.9);
      font-size: 12px;
    }

    @media (max-width: 720px){
      .grid{ grid-template-columns: 1fr; }
      .badge{ display:none; }
    }

    @media (prefers-reduced-motion: reduce){
      *{ animation:none !important; transition:none !important; }
    }
  </style>
</head>

<body>
  <div class="blob one"></div>
  <div class="blob two"></div>
  <div class="blob three"></div>

  <%
    Reservation r = (Reservation) request.getAttribute("r");
  %>

  <div class="wrap">
    <div class="card">

      <div class="header">
        <div class="title">
          <div class="icon" aria-hidden="true">✏️</div>
          <div>
            <h2>Edit Reservation</h2>
            <div class="sub">Update guest details and save changes.</div>
          </div>
        </div>

        <div class="badge">
          <span class="dot"></span>
          Editing ID: <b><%= (r != null ? r.getId() : 0) %></b>
        </div>
      </div>

      <div class="content">

        <% if (r == null) { %>
          <p style="color: rgba(239,68,68,.95); margin:0;">
            ❌ No reservation data found (request attribute <b>"r"</b> is null).
          </p>
          <p style="margin:10px 0 0;">
            <a class="link" href="<%= request.getContextPath() %>/reservation/list">Back to list</a>
          </p>
        <% } else { %>

        <form action="<%= request.getContextPath() %>/reservation/update" method="post" autocomplete="on">
          <input type="hidden" name="id" value="<%= r.getId() %>">

          <div class="grid">
            <div class="field">
              <label>Guest Name</label>
              <span class="mini-ic" aria-hidden="true">N</span>
              <input name="guestName" value="<%= r.getGuestName() %>" required>
            </div>

            <div class="field">
              <label>Email</label>
              <span class="mini-ic" aria-hidden="true">@</span>
              <input type="email" name="email" value="<%= r.getEmail() %>" required>
            </div>
          </div>

          <div class="grid">
            <div class="field">
              <label>Phone</label>
              <span class="mini-ic" aria-hidden="true">☎</span>
              <input name="phone" value="<%= r.getPhone() %>">
            </div>

            <div class="field">
              <label>Room Type</label>
              <span class="mini-ic" aria-hidden="true">🛏</span>
              <input name="roomType" value="<%= r.getRoomType() %>">
            </div>
          </div>

          <div class="grid">
            <div class="field">
              <label>Check In</label>
              <span class="mini-ic" aria-hidden="true">📅</span>
              <input name="checkIn" value="<%= r.getCheckIn() %>">
            </div>

            <div class="field">
              <label>Check Out</label>
              <span class="mini-ic" aria-hidden="true">📆</span>
              <input name="checkOut" value="<%= r.getCheckOut() %>">
            </div>
          </div>

          <div class="actions">
            <button class="btn-primary" type="submit">Update</button>
            <button class="btn-ghost" type="reset">Reset</button>
          </div>

        </form>

        <% } %>
      </div>

      <div class="footer">
        <div class="hint">Tip: Email should remain valid. Review dates before saving.</div>
        <a class="link" href="<%= request.getContextPath() %>/reservation/list">← Back to list</a>
      </div>

    </div>
  </div>
</body>
</html>
