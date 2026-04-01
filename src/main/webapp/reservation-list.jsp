<%@ page import="java.util.*,hotel.model.Reservation" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservations</title>

<style>
  :root{
    --bg1:#0b1220; --bg2:#0f172a;
    --card:rgba(17,24,39,.72);
    --stroke:rgba(148,163,184,.18);
    --text:#e5e7eb; --muted:#94a3b8;
    --accent:#7c3aed; --accent2:#22c55e; --danger:#ef4444;
    --shadow:0 24px 70px rgba(0,0,0,.45);
    --radius:18px;
  }
  *{box-sizing:border-box}
  body{
    margin:0; min-height:100vh; padding:18px;
    font-family:system-ui,Segoe UI,Roboto,Arial;
    color:var(--text);
    background:
      radial-gradient(900px 600px at 15% 10%, rgba(124,58,237,.26), transparent 55%),
      radial-gradient(900px 600px at 90% 25%, rgba(34,197,94,.18), transparent 55%),
      linear-gradient(180deg,var(--bg1),var(--bg2));
    display:grid; place-items:start center;
  }
  .wrap{width:min(1100px,96vw); animation:in .7s ease both;}
  @keyframes in{from{opacity:0; transform:translateY(14px)}to{opacity:1; transform:none}}
  .top{
    display:flex; justify-content:space-between; align-items:center; gap:12px;
    margin-bottom:14px;
  }
  h2{margin:0; font-size:24px; letter-spacing:.2px}
  .btn{
    display:inline-flex; align-items:center; gap:10px;
    padding:10px 14px; border-radius:12px;
    border:1px solid var(--stroke);
    background:linear-gradient(135deg,var(--accent),#2563eb);
    color:#fff; font-weight:800; text-decoration:none;
    box-shadow:0 16px 34px rgba(124,58,237,.22);
    transition:transform .18s ease, filter .18s ease;
  }
  .btn:hover{transform:translateY(-1px); filter:brightness(1.05)}
  .card{
    background:linear-gradient(180deg, rgba(17,24,39,.78), rgba(17,24,39,.55));
    border:1px solid var(--stroke);
    border-radius:var(--radius);
    box-shadow:var(--shadow);
    overflow:hidden;
    backdrop-filter: blur(10px);
  }
  table{width:100%; border-collapse:collapse}
  thead th{
    text-align:left; padding:12px 12px;
    font-size:12px; letter-spacing:.35px;
    color:rgba(229,231,235,.85);
    background:rgba(2,6,23,.25);
    border-bottom:1px solid rgba(148,163,184,.14);
    position:sticky; top:0;
  }
  tbody td{
    padding:12px 12px;
    border-bottom:1px solid rgba(148,163,184,.10);
    color:rgba(229,231,235,.92);
    font-size:13px;
  }
  tbody tr{
    transition:transform .15s ease, background .15s ease;
  }
  tbody tr:hover{
    background:rgba(124,58,237,.08);
    transform:translateX(2px);
  }
  .actions a{
    text-decoration:none; font-weight:800;
    padding:8px 10px; border-radius:10px;
    border:1px solid rgba(148,163,184,.18);
    background:rgba(2,6,23,.20);
    color:rgba(229,231,235,.92);
    transition:transform .15s ease, filter .15s ease;
    display:inline-block;
  }
  .actions a:hover{transform:translateY(-1px); filter:brightness(1.1)}
  .actions a.delete{border-color:rgba(239,68,68,.35); color:rgba(239,68,68,.95)}
  .pill{
    display:inline-flex; align-items:center; gap:8px;
    padding:6px 10px; border-radius:999px;
    border:1px solid rgba(148,163,184,.18);
    background:rgba(2,6,23,.20);
    color:rgba(148,163,184,.95);
    font-size:12px;
  }
  @media(max-width:900px){
    .hide-md{display:none}
  }
</style>
</head>

<body>
<div class="wrap">
  <div class="top">
    <div>
      <h2>📋 Reservations</h2>
      <div class="pill">Manage • Edit • Delete</div>
    </div>
    <a class="btn" href="<%= request.getContextPath() %>/reservation-form.jsp">+ New Reservation</a>
  </div>

  <div class="card">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th class="hide-md">Email</th>
          <th>Phone</th>
          <th>Room</th>
          <th>In</th>
          <th>Out</th>
          <th>Action</th>
        </tr>
      </thead>

      <tbody>
      <%
        List<Reservation> list = (List<Reservation>) request.getAttribute("list");
        if(list != null){
          for(Reservation r : list){
      %>
        <tr>
          <td><%= r.getId() %></td>
          <td><%= r.getGuestName() %></td>
          <td class="hide-md"><%= r.getEmail() %></td>
          <td><%= r.getPhone() %></td>
          <td><%= r.getRoomType() %></td>
          <td><%= r.getCheckIn() %></td>
          <td><%= r.getCheckOut() %></td>
          <td class="actions">
            <a href="<%= request.getContextPath() %>/reservation/edit?id=<%= r.getId() %>">Edit</a>
            <a class="delete"
               href="<%= request.getContextPath() %>/reservation/delete?id=<%= r.getId() %>"
               onclick="return confirm('Delete this reservation?')">Delete</a>
          </td>
        </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
