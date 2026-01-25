<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hotel Reservation</title>

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
      --blue:#2563eb;
      --shadow: 0 26px 80px rgba(0,0,0,.5);
      --r: 18px;
    }

    *{ box-sizing:border-box; }
    body{
      margin:0;
      min-height:100vh;
      display:grid;
      place-items:center;
      padding:18px;
      font-family: ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,Arial;
      color:var(--text);
      background:
        radial-gradient(1000px 650px at 12% 12%, rgba(124,58,237,.26), transparent 55%),
        radial-gradient(900px 550px at 90% 25%, rgba(34,197,94,.16), transparent 55%),
        radial-gradient(900px 550px at 50% 90%, rgba(59,130,246,.14), transparent 55%),
        linear-gradient(180deg, var(--bg1), var(--bg2));
      overflow-x:hidden;
    }

    /* floating blobs */
    .blob{
      position:fixed;
      width:440px;height:440px;
      border-radius:50%;
      filter: blur(42px);
      opacity:.22;
      z-index:-1;
      animation: float 10s ease-in-out infinite;
    }
    .blob.one{ left:-160px; top:-140px; background:rgba(124,58,237,.95); }
    .blob.two{ right:-170px; top:120px; background:rgba(34,197,94,.9); animation-duration:12s; }
    .blob.three{ left:30%; bottom:-210px; background:rgba(59,130,246,.9); animation-duration:14s; }

    @keyframes float{
      0%,100%{ transform: translate(0,0) scale(1); }
      50%{ transform: translate(18px,-18px) scale(1.06); }
    }

    .wrap{
      width: min(980px, 96vw);
      display:grid;
      grid-template-columns: 1.05fr .95fr;
      gap:18px;
      align-items:stretch;
      animation: enter .75s cubic-bezier(.2,.9,.2,1) both;
    }
    @keyframes enter{
      from{ opacity:0; transform: translateY(14px) scale(.99); }
      to{ opacity:1; transform: translateY(0) scale(1); }
    }

    .card{
      background: linear-gradient(180deg, rgba(17,24,39,.78), rgba(17,24,39,.55));
      border: 1px solid var(--stroke);
      border-radius: var(--r);
      box-shadow: var(--shadow);
      backdrop-filter: blur(10px);
      overflow:hidden;
      position:relative;
    }

    .left{ padding:20px 20px 18px; }
    .right{ padding:18px 18px 18px; display:flex; flex-direction:column; gap:12px; }

    .brand{
      display:flex; gap:12px; align-items:center;
      margin-bottom:12px;
    }
    .logo{
      width:46px;height:46px;border-radius:14px;
      background:
        radial-gradient(circle at 30% 30%, rgba(255,255,255,.35), transparent 55%),
        linear-gradient(135deg, var(--accent), var(--blue));
      box-shadow: 0 14px 30px rgba(124,58,237,.25);
      position:relative;
      overflow:hidden;
      flex:0 0 auto;
    }
    .logo::after{
      content:"";
      position:absolute;
      inset:-40%;
      background: linear-gradient(120deg, transparent 35%, rgba(255,255,255,.35), transparent 65%);
      transform: translateX(-45%) rotate(18deg);
      animation: shine 2.6s ease-in-out infinite;
      opacity:.7;
    }
    @keyframes shine{
      0%{ transform: translateX(-55%) rotate(18deg); opacity:0; }
      35%{ opacity:.75; }
      100%{ transform: translateX(55%) rotate(18deg); opacity:0; }
    }

    h2{ margin:0; font-size:24px; letter-spacing:.2px; }
    .sub{ margin:6px 0 0; color:var(--muted); font-size:13px; line-height:1.4; }

    form{ display:grid; gap:12px; margin-top:14px; }

    .grid{ display:grid; grid-template-columns: 1fr 1fr; gap:12px; }
    .field{ position:relative; }

    label{
      display:block;
      margin: 0 0 6px;
      font-size: 12px;
      color: rgba(229,231,235,.88);
      letter-spacing:.25px;
    }

    input, select{
      width:100%;
      padding: 12px 12px 12px 42px;
      border-radius: 12px;
      border: 1px solid rgba(148,163,184,.18);
      background: rgba(2,6,23,.25);
      color: var(--text);
      outline:none;
      transition: transform .18s ease, border-color .18s ease, box-shadow .18s ease, background .18s ease;
    }
    input::placeholder{ color: rgba(148,163,184,.75); }
    input:focus, select:focus{
      border-color: rgba(124,58,237,.85);
      box-shadow: 0 0 0 4px rgba(124,58,237,.18);
      background: rgba(2,6,23,.35);
      transform: translateY(-1px);
    }

    /* small icon bubble */
    .ic{
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
      transition: transform .18s ease, background .18s ease;
    }
    .field:focus-within .ic{
      transform: translateY(-1px) scale(1.06);
      background: rgba(124,58,237,.18);
    }

    .actions{
      display:flex;
      gap:12px;
      margin-top:6px;
      align-items:center;
    }

    button{
      border:none;
      cursor:pointer;
      padding: 12px 14px;
      border-radius: 12px;
      font-weight: 900;
      letter-spacing:.2px;
      transition: transform .18s ease, box-shadow .18s ease, filter .18s ease;
      will-change: transform;
    }

    .btn-primary{
      flex:1;
      color:#fff;
      background: linear-gradient(135deg, var(--accent), var(--blue));
      box-shadow: 0 16px 34px rgba(124,58,237,.22);
      position:relative;
      overflow:hidden;
    }
    .btn-primary::after{
      content:"";
      position:absolute;
      inset:-40%;
      background: linear-gradient(120deg, transparent 35%, rgba(255,255,255,.35), transparent 65%);
      transform: translateX(-55%) rotate(18deg);
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
      0%{ transform: translateX(-65%) rotate(18deg); }
      100%{ transform: translateX(65%) rotate(18deg); }
    }

    .btn-ghost{
      color: rgba(229,231,235,.92);
      background: rgba(2,6,23,.25);
      border: 1px solid rgba(148,163,184,.18);
    }
    .btn-ghost:hover{ transform: translateY(-1px); filter: brightness(1.08); }

    .hint{
      margin-top: 2px;
      font-size: 12px;
      color: rgba(148,163,184,.92);
      line-height: 1.45;
    }

    /* right panel cards */
    .pill{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding: 8px 10px;
      width:max-content;
      border-radius: 999px;
      border: 1px solid rgba(148,163,184,.18);
      background: rgba(2,6,23,.25);
      font-size: 12px;
      color: rgba(229,231,235,.92);
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

    .info{
      border:1px solid rgba(148,163,184,.18);
      background: rgba(2,6,23,.20);
      border-radius: 14px;
      padding: 12px;
      transition: transform .18s ease, border-color .18s ease;
    }
    .info:hover{
      transform: translateY(-2px);
      border-color: rgba(124,58,237,.45);
    }
    .info h3{ margin:0 0 6px; font-size:14px; letter-spacing:.2px; }
    .info p{ margin:0; color: rgba(148,163,184,.92); font-size:13px; line-height:1.5; }

    @media(max-width: 860px){
      .wrap{ grid-template-columns: 1fr; }
      .grid{ grid-template-columns: 1fr; }
      .right{ display:none; }
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

  <div class="wrap">
    <section class="card left">
      <div class="brand">
        <div class="logo" aria-hidden="true"></div>
        <div>
          <h2>🏨 Hotel Reservation</h2>
          <div class="sub">Fill your details and book a room. Data will be saved in MySQL via Servlet + JDBC.</div>
        </div>
      </div>

      <form action="<%= request.getContextPath() %>/reservation/create" method="post" autocomplete="on">

        <div class="grid">
          <div class="field">
            <label>Guest Name</label>
            <span class="ic" aria-hidden="true">N</span>
            <input name="guestName" required placeholder="Full name"/>
          </div>

          <div class="field">
            <label>Phone</label>
            <span class="ic" aria-hidden="true">☎</span>
            <input name="phone" placeholder="98xxxxxx"/>
          </div>
        </div>

        <div class="field">
          <label>Email</label>
          <span class="ic" aria-hidden="true">@</span>
          <input type="email" name="email" required placeholder="name@gmail.com"/>
        </div>

        <div class="field">
          <label>Room Type</label>
          <span class="ic" aria-hidden="true">🛏</span>
          <select name="roomType">
            <option>Single</option>
            <option>Double</option>
            <option>Deluxe</option>
            <option>Suite</option>
          </select>
        </div>

        <div class="grid">
          <div class="field">
            <label>Check-In (YYYY-MM-DD)</label>
            <span class="ic" aria-hidden="true">📅</span>
            <input name="checkIn" placeholder="2026-01-24"/>
          </div>

          <div class="field">
            <label>Check-Out (YYYY-MM-DD)</label>
            <span class="ic" aria-hidden="true">📆</span>
            <input name="checkOut" placeholder="2026-01-25"/>
          </div>
        </div>

        <div class="actions">
          <button class="btn-primary" type="submit">Book Now</button>
          <button class="btn-ghost" type="reset">Reset</button>
        </div>

        <div class="hint">
          Tip: After submit, open <b><%= request.getContextPath() %>/reservation/list</b> to view/edit/delete bookings.
        </div>
      </form>
    </section>

    <aside class="card right">
      <div class="pill"><span class="dot"></span> Live Booking Form</div>

      <div class="info">
        <h3>⚡ Fast UI</h3>
        <p>Clean layout, focus glow, hover micro-animations, and responsive design.</p>
      </div>

      <div class="info">
        <h3>🗄 Database Ready</h3>
        <p>Form submit → Servlet → DAO → MySQL (PreparedStatement).</p>
      </div>

      <div class="info">
        <h3>✅ Next</h3>
        <p>Open the list page to update and delete reservations in one click.</p>
      </div>
    </aside>
  </div>
</body>
</html>
