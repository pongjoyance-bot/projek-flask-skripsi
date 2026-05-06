from flask import Flask, render_template, request, redirect, url_for, abort
import mysql.connector
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
from flask import session, flash
from werkzeug.security import generate_password_hash, check_password_hash
from flask import Flask, render_template, request, redirect, url_for, flash, session
from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash
import os
from werkzeug.utils import secure_filename
from flask import request, session, redirect, url_for, flash, jsonify
from functools import wraps
from flask import session, redirect, url_for, flash
import json
from collections import defaultdict, Counter
import math
import time
from functools import lru_cache



app = Flask(__name__)
app.secret_key = "ini_secret_key_saya"
import os
import mysql.connector

host = os.getenv("MYSQLHOST")
user = os.getenv("MYSQLUSER")
password = os.getenv("MYSQLPASSWORD")
database = os.getenv("MYSQLDATABASE")
port = int(os.getenv("MYSQLPORT", 3306))

print("=== DEBUG ENV ===")
print("MYSQLHOST:", host)
print("MYSQLUSER:", user)
print("MYSQLDATABASE:", database)
print("=================")

if not host:
    raise Exception("MYSQLHOST tidak terbaca di Railway!")

db = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database,
    port=port
)
cursor = db.cursor(dictionary=True,buffered=True)
@app.context_processor
def inject_cart_count():
    id_user = session.get("user_id")
    cart_count = 0
    if id_user:
        cursor.execute(
            "SELECT SUM(jumlah) AS total FROM cart WHERE id_user = %s", (id_user,)
        )
        result = cursor.fetchone()
        cart_count = result["total"] if result and result["total"] else 0
    return dict(cart_count=cart_count)

@app.context_processor
def inject_wishlist_count():
    if "user_id" in session:
        cursor.execute("""
            SELECT COUNT(*) AS total
            FROM wishlist
            WHERE id_user = %s
        """, (session["user_id"],))
        result = cursor.fetchone()
        return dict(wishlist_count=result["total"] if result else 0)
    return dict(wishlist_count=0)



# homepage/katalog produk
@app.route("/")
def home():
    id_user = session.get("user_id")

    cart_count = 0
    if id_user:
        cursor.execute("SELECT SUM(jumlah) AS total FROM cart WHERE id_user = %s", (id_user,))
        result = cursor.fetchone()
        cart_count = result["total"] if result and result["total"] else 0

    #filter
    harga_min = request.args.get("harga_min")
    harga_max = request.args.get("harga_max")
    storage = request.args.get("storage", type=int)
    rating = request.args.get("rating", type=int)
    ram = request.args.get("ram", type=int)
    merek_aktif = request.args.get("brand")
    sort = request.args.get("sort", "terbaru")
    keyword = request.args.get("q", "")
    varian_filter = request.args.get("varian")
    chipset = request.args.get("chipset")
    layar = request.args.get("layar")
    kamera = request.args.get("kamera")
    baterai = request.args.get("baterai")

    if harga_min:
        harga_min = int(harga_min.replace(".", ""))

    if harga_max:
        harga_max = int(harga_max.replace(".", ""))

    # query produkk
    query = """
        SELECT 
            d.*,
            b.nama_brand,
            MIN(v.harga) AS harga_terendah,
            SUM(vd.stok) AS total_stok
        FROM data d
        LEFT JOIN brand b ON d.id_brand = b.id_brand
        JOIN varian_produk v ON d.id_produk = v.id_produk
        JOIN varian_detail vd ON v.id_varian = vd.id_varian
        WHERE 1=1
    """

    params = []

    if merek_aktif:
        query += " AND d.id_brand = %s"
        params.append(merek_aktif)

    if keyword:
        query += " AND d.nama_produk LIKE %s"
        params.append(f"%{keyword}%")

    if harga_min:
        query += " AND v.harga >= %s"
        params.append(harga_min)

    if harga_max:
        query += " AND v.harga <= %s"
        params.append(harga_max)

    if storage:
        query += " AND d.penyimpanan = %s"
        params.append(storage)

    if ram:
        query += " AND d.ram = %s"
        params.append(ram)

    if varian_filter:
        query += " AND v.nama_varian = %s"
        params.append(varian_filter)
    if chipset:
        query += " AND d.chipset LIKE %s"
        params.append(f"%{chipset}%")

    if layar:
        query += " AND d.layar LIKE %s"
        params.append(f"%{layar}%")

    if kamera:
        query += " AND d.kamera >= %s"
        params.append(kamera)

    if baterai:
        query += " AND d.baterai >= %s"
        params.append(baterai)

    if rating:
        query += """
            GROUP BY d.id_produk
            HAVING total_stok > 0 AND
            (
                SELECT IFNULL(AVG(r.rating),0)
                FROM rating r
                WHERE r.id_produk = d.id_produk
            ) >= %s
        """
        params.append(rating)
    else:
        query += " GROUP BY d.id_produk HAVING total_stok > 0 "

    query += apply_sort_sql(sort)
    query += " LIMIT 9"

    cursor.execute(query, tuple(params))
    smartphones_populer = cursor.fetchall()

    cursor.execute("""
    SELECT id_produk, SUM(jumlah) AS total_jual
    FROM order_detail
    GROUP BY id_produk
    ORDER BY total_jual DESC
    LIMIT 5
""")
    
    user_baru = True

    if 'user_id' in session:

        cursor.execute("""
        SELECT COUNT(*) as total
        FROM orders
        WHERE id_user = %s
        """, (session['user_id'],))

        result = cursor.fetchone()
        total_pembelian = result['total']

        if total_pembelian > 0:
            user_baru = False

    terlaris_ids = [row["id_produk"] for row in cursor.fetchall()]

    cursor.execute("""
        SELECT DISTINCT nama_varian
        FROM varian_produk
        ORDER BY nama_varian ASC
    """)

    daftar_varian = cursor.fetchall()

    warna_map = {
    "hitam": "#000000",
    "putih": "#FFFFFF",
    "biru": "#1E90FF",
    "merah": "#FF0000",
    "ungu": "#800080",
    "silver": "#C0C0C0",
    "hijau": "#32CD32",
    "abu-abu": "#808080",
    "kuning": "#FFD700",
}

    cursor.execute("""
        SELECT id_produk, AVG(rating) AS avg_rating, COUNT(*) AS total_rating
        FROM rating
        GROUP BY id_produk
    """)

    rating_map = {
        r["id_produk"]: {
            "avg": float(r["avg_rating"]),
            "count": r["total_rating"]
        }
        for r in cursor.fetchall()
    }

    

    wishlist_ids = set()

    if id_user:
        cursor.execute("""
            SELECT id_produk FROM wishlist WHERE id_user=%s
        """, (id_user,))
        wishlist_ids = {w["id_produk"] for w in cursor.fetchall()}

    smartphones_populer = sort_rekomendasi(smartphones_populer, sort)

    # roduk terbaru
    cursor.execute("""
    SELECT id_produk
    FROM data
    ORDER BY id_produk DESC
    LIMIT 6
""")

    produk_terbaru_ids = [row["id_produk"] for row in cursor.fetchall()]


    # Ambil brand
    cursor.execute("SELECT * FROM brand ORDER BY nama_brand ASC")
    brands = cursor.fetchall()

    # Load user-item data
    user_items = load_user_items(cursor)
    sim = compute_item_similarity(user_items)

    # Rekomendasi IBCF
    # ================= REKOMENDASI =================
    if id_user and id_user in user_items and len(user_items[id_user]) > 0:
        rekomendasi_user = recommend_for_user(cursor, id_user, sim, user_items, N=12)
    else:
        rekomendasi_user = trending_products(cursor, limit=20, chipset=chipset,
        layar=layar,
        kamera=kamera,
        baterai=baterai)
       
        

    rekomendasi_user = filter_rekomendasi(
        cursor,
        rekomendasi_user,
        harga_min,
        harga_max,
        storage,
        rating,
        ram,
        keyword,
        merek_aktif,
        varian_filter
)

    # ===== TAMBAHKAN LOOP INI DI LUAR IF =====
    for produk in rekomendasi_user:

        # RATING
        r = rating_map.get(produk["id_produk"])
        produk["avg_rating"] = round(r["avg"], 1) if r else None
        produk["total_rating"] = r["count"] if r else 0

        # HARGA TERENDAH
        cursor.execute("""
            SELECT MIN(harga) AS harga_terendah
            FROM varian_produk
            WHERE id_produk = %s
        """, (produk["id_produk"],))

        h = cursor.fetchone()
        produk["harga_terendah"] = h["harga_terendah"] if h and h["harga_terendah"] else 0

        # VARIAN SPEC
        cursor.execute("""
            SELECT DISTINCT v.nama_varian
            FROM varian_produk v
            JOIN varian_detail vd ON v.id_varian = vd.id_varian
            WHERE v.id_produk = %s AND vd.stok > 0
        """, (produk["id_produk"],))
        produk["varian_spec"] = cursor.fetchall()

        # WARNA
        cursor.execute("""
            SELECT vd.warna
            FROM varian_detail vd
            JOIN varian_produk v ON vd.id_varian = v.id_varian
            WHERE v.id_produk = %s AND vd.stok > 0
        """, (produk["id_produk"],))
        warna_list = cursor.fetchall()

        for w in warna_list:
            w["warna_hex"] = warna_map.get(w["warna"].lower(), "#999999")

        produk["warna_varian"] = warna_list

        # BADGE
        produk["is_terbaru"] = produk["id_produk"] in produk_terbaru_ids
        produk["is_terlaris"] = produk["id_produk"] in terlaris_ids
        produk["is_favorit"] = produk["avg_rating"] and produk["avg_rating"] >= 4.5
        produk["is_rating_tinggi"] = produk["avg_rating"] and produk["avg_rating"] >= 4
        produk["is_wishlist"] = produk["id_produk"] in wishlist_ids
        r = rating_map.get(produk["id_produk"])

        produk["avg_rating"] = round(r["avg"], 1) if r else None
        produk["total_rating"] = r["count"] if r else 0
    rekomendasi_user = sort_rekomendasi(rekomendasi_user, sort)
    

    # Tambah varian warna stok > 0
    warna_map = {
        "hitam": "#000000",
        "putih": "#FFFFFF",
        "biru metalik": "#4682B4",
        "merah": "#FF0000",
        "ungu": "#800080",
        "silver": "#C0C0C0",
        "hijau": "#32CD32",
        "abu-abu": "#808080",
        "kuning": "#FFD700",    
        "biru": "#1E90FF", 
    }

    for produk in smartphones_populer:
    # WARNA
        cursor.execute("""
            SELECT vd.warna
            FROM varian_detail vd
            JOIN varian_produk v ON vd.id_varian = v.id_varian
            WHERE v.id_produk = %s AND vd.stok > 0
        """, (produk["id_produk"],))

        varian = cursor.fetchall()

        for v in varian:
             v["warna_hex"] = warna_map.get(v["warna"].lower(), "#999999")

        produk["warna_varian"] = varian

        # RATING
        cursor.execute("""
            SELECT AVG(rating) AS avg_rating, COUNT(*) AS total_rating
            FROM rating
            WHERE id_produk = %s
        """, (produk["id_produk"],))

        r = cursor.fetchone()

        produk["avg_rating"] = round(r["avg_rating"], 1) if r and r["avg_rating"] else None
        produk["total_rating"] = r["total_rating"] if r else 0

       

    # ================= VARIAN RAM & STORAGE =================
        cursor.execute("""
        SELECT DISTINCT v.nama_varian
        FROM varian_produk v
        JOIN varian_detail vd ON v.id_varian = vd.id_varian
        WHERE v.id_produk = %s AND vd.stok > 0
    """, (produk["id_produk"],))

        varian_spec = cursor.fetchall()

        produk["varian_spec"] = varian_spec

        # BADGE
        produk["is_terbaru"] = produk["id_produk"] in produk_terbaru_ids
        produk["is_terlaris"] = produk["id_produk"] in terlaris_ids
        produk["is_favorit"] = produk["avg_rating"] and produk["avg_rating"] >= 4.5
        produk["is_rating_tinggi"] = produk["avg_rating"] and produk["avg_rating"] >= 4
        produk["is_wishlist"] = produk["id_produk"] in wishlist_ids
   
    return render_template(
        "homepage.html",
        smartphones_populer=smartphones_populer,
        rekomendasi_user=rekomendasi_user,
        cart_count=cart_count,
        keyword=keyword,
        brands=brands,
        merek_aktif=merek_aktif,
        harga_min=harga_min,
        harga_max=harga_max,
        storage=storage,
         rating=rating,
         sort=sort,
         ram=ram,
         user_baru=user_baru,
         daftar_varian=daftar_varian

    )

def filter_rekomendasi(cursor, produk_list, harga_min=None, harga_max=None,
                       storage=None, rating=None, ram=None,keyword=None,brand=None,varian=None):


    hasil = []

    for p in produk_list:
        harga_produk = int(p.get("harga_terendah") or 0)


        # FILTER HARGA
        if harga_min and harga_produk < harga_min:
            continue
        if harga_max and harga_produk > harga_max:
            continue

        # FILTER STORAGE
        if storage and str(storage) not in (p.get("spesifikasi") or ""):
            continue

        # FILTER RAM
        if ram and int(p.get("ram", 0)) != int(ram):
            continue        
        # FILTER BRAND
        if brand and str(p.get("id_brand")) != str(brand):
            continue

        if keyword and keyword.lower() not in p["nama_produk"].lower():
          continue

        # FILTER RATING
        if rating:
            cursor.execute("""
                SELECT AVG(rating) AS avg_rating
                FROM rating
                WHERE id_produk = %s
            """, (p["id_produk"],))
            r = cursor.fetchone()
            if not r or not r["avg_rating"] or float(r["avg_rating"]) < rating:
                continue
        if varian:
            cursor.execute("""
                SELECT nama_varian
                FROM varian_produk
                WHERE id_produk = %s
            """, (p["id_produk"],))

            varian_list = [v["nama_varian"] for v in cursor.fetchall()]

            if varian not in varian_list:
                continue

        hasil.append(p)

    return hasil

def apply_sort_sql(sort):
    if sort == "harga_asc":
         return "ORDER BY harga_terendah ASC"
    elif sort == "harga_desc":
        return "ORDER BY harga_terendah DESC"
    elif sort == "rating":
        return """
        ORDER BY (
            SELECT IFNULL(AVG(r.rating), 0)
            FROM rating r
            WHERE r.id_produk = d.id_produk
        ) DESC
        """
    elif sort == "terlaris":
        return """
        ORDER BY (
            SELECT IFNULL(SUM(od.jumlah), 0)
            FROM order_detail od
            WHERE od.id_produk = d.id_produk
        ) DESC
        """
    else:
        return "ORDER BY d.id_produk DESC"


def sort_rekomendasi(data, sort):

    if sort == "rating":
        return sorted(
            data,
            key=lambda x: x.get("avg_rating") or 0,
            reverse=True
        )

    elif sort == "harga_asc":
        return sorted(
            data,
            key=lambda x: x.get("harga_terendah") or 0
        )

    elif sort == "harga_desc":
        return sorted(
            data,
            key=lambda x: x.get("harga_terendah") or 0,
            reverse=True
        )

    else:
        return data

# merek    
@app.route("/filter/<merek>")
def filter_brand(merek):
    cursor.execute("SELECT * FROM data WHERE merek = %s", (merek,))
    produk_kategori = cursor.fetchall()

    # Mapping warna -> HEX
    warna_map = {
        "hitam": "#000000",
        "putih": "#FFFFFF",
        "biru metalik": "#4682B4",
        "merah": "#FF0000",
        "ungu": "#800080",
        "silver": "#C0C0C0",
        "hijau": "#32CD32",
        "abu-abu": "#808080",
    }

    # Tambahkan varian warna
    for produk in produk_kategori:
        cursor.execute(
            "SELECT warna, stok FROM varian_warna WHERE id_produk = %s",
            (produk["id_produk"],),
        )
        varian = cursor.fetchall()

        for v in varian:
          v["warna_hex"] = warna_map.get(v["warna"].lower(), "#CCCCCC")

        produk["warna_varian"] = varian

    # rekomendasi acak
    cursor.execute("SELECT * FROM data ORDER BY RAND() LIMIT 6")
    rekomendasi_user = cursor.fetchall()

    return render_template(
        "homepage.html",
        smartphones_populer=produk_kategori,
        rekomendasi_user=rekomendasi_user,
        merek_aktif=merek,
    )

#detail produk
@app.route("/detail/<int:id_produk>")
def detail_produk(id_produk):

    id_user = session.get("user_id")

    # Produk utama
    cursor.execute("SELECT * FROM data WHERE id_produk=%s", (id_produk,))
    produk = cursor.fetchone()

    # Ambil semua varian
    cursor.execute("""
        SELECT id_varian, nama_varian, harga
        FROM varian_produk
        WHERE id_produk=%s
    """, (id_produk,))
    varian_list = cursor.fetchall()

    # Ambil semua warna + stok per varian
    cursor.execute("""
        SELECT id_varian, warna, stok
        FROM varian_detail
        WHERE id_varian IN (
            SELECT id_varian FROM varian_produk WHERE id_produk=%s
        )
    """, (id_produk,))
    warna_data = cursor.fetchall()

    # Group warna berdasarkan id_varian
    warna_map = {}
    for w in warna_data:
        warna_map.setdefault(w["id_varian"], []).append(w)

    # Tambahkan warna ke masing-masing varian
    for v in varian_list:
        v["warna_list"] = warna_map.get(v["id_varian"], [])

    # Harga default
    if varian_list:
        produk["harga_default"] = min(v["harga"] for v in varian_list)
    else:
        produk["harga_default"] = 0

    # Gambar lain
    cursor.execute("SELECT * FROM produk_gambar WHERE id_produk=%s", (id_produk,))
    gambar_lain = cursor.fetchall()

    # Rekomendasi (biarkan seperti punya kamu)
    user_items = load_user_items(cursor)
    sim = compute_item_similarity(user_items)

    if id_user and id_user in user_items and user_items[id_user]:
        rekomendasi = recommend_for_user(cursor, id_user, sim, user_items, N=4)
    else:
        rekomendasi = trending_products(cursor, limit=4)
        

    return render_template(
        "detail.html",
        produk=produk,
        varian_list=varian_list,
        gambar_lain=gambar_lain,
        rekomendasi=rekomendasi,
    )

app.secret_key = "secret123" 


import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

def get_rekomendasi_ibcf(id_produk, top_n=4):

    # 1. Ambil data rating dari DB
    cursor.execute("""
        SELECT id_user, id_produk, rating
        FROM rating
    """)
    data = cursor.fetchall()

    if not data:
        return []

    # 2. Konversi ke DataFrame
    df = pd.DataFrame(data)

    # 3. Pivot user-item
    pivot = df.pivot_table(
        index="id_user",
        columns="id_produk",
        values="rating"
    ).fillna(0)

    # 4. Hitung similarity antar item
    similarity = cosine_similarity(pivot.T)
    sim_df = pd.DataFrame(
        similarity,
        index=pivot.columns,
        columns=pivot.columns
    )

    # 5. Jika produk belum punya rating
    if id_produk not in sim_df.index:
        return []

    # 6. Ambil produk paling mirip
    similar_items = (
        sim_df[id_produk]
        .sort_values(ascending=False)
        .iloc[1:top_n+1]
    )

    rekomendasi_ids = similar_items.index.tolist()

    # 7. Ambil detail produk
    format_str = ",".join(["%s"] * len(rekomendasi_ids))
    cursor.execute(
        f"SELECT * FROM data WHERE id_produk IN ({format_str})",
        tuple(rekomendasi_ids)
    )

    return cursor.fetchall()

# tambah ke keranjang
@app.route("/add_to_cart/<int:id_produk>", methods=["POST"])
def add_to_cart(id_produk):
    if "user_id" not in session:
        flash("Silakan login dulu.", "warning")
        return redirect(url_for("login"))

    id_user = session["user_id"]
    jumlah = int(request.form.get("jumlah", 1))
    id_varian = request.form.get("id_varian")
    warna = request.form.get("warna")

    # Ambil harga dari varian utama
    cursor.execute("SELECT harga FROM varian_produk WHERE id_varian=%s", (id_varian,))
    res = cursor.fetchone()
    harga = res["harga"] if res else 0

    # Cek apakah item sudah ada di cart
    cursor.execute("""
        SELECT * FROM cart 
        WHERE id_user=%s AND id_produk=%s AND id_varian=%s
    """, (id_user, id_produk, id_varian))
    existing = cursor.fetchone()

    if existing:
        cursor.execute("""
            UPDATE cart SET jumlah = jumlah + %s WHERE id_cart=%s
        """, (jumlah, existing["id_cart"]))
    else:
        cursor.execute("""
            INSERT INTO cart (id_user, id_produk, id_varian, jumlah, warna)
            VALUES (%s,%s,%s,%s,%s)
        """, (id_user, id_produk, id_varian, jumlah, warna))

    db.commit()
    flash("Produk ditambahkan ke keranjang!", "success")
    return redirect(url_for("cart"))

#ubah varian warna
@app.route("/update_varian_cart", methods=["POST"])
def update_varian_cart():
    id_cart = request.form["id_cart"]
    id_varian = request.form["id_varian"]  
    

    cursor.execute(
        """
        UPDATE cart 
        SET id_varian = %s
        WHERE id_cart = %s
    """,
        (id_varian if id_varian != "" else None, id_cart),
    )
    db.commit()

    flash("Warna berhasil diperbarui.", "success")
    return redirect(url_for("cart"))


import uuid
import qrcode
import base64
from io import BytesIO

def generate_billing_code():
    prefix = "8808"  
    random_part = str(random.randint(1000000000, 9999999999))
    return prefix + random_part

def generate_qris_code(data):
    qr = qrcode.make(data)
    buf = BytesIO()
    qr.save(buf, format="PNG")
    return base64.b64encode(buf.getvalue()).decode()

@app.route('/generate-kode-pembayaran')
def generate_kode_pembayaran():
    kode = "BRIVA" + str(random.randint(1000000000, 9999999999))
    return jsonify({"kode": kode})


# checkout
@app.route("/checkout", methods=["POST"])
def checkout():
    if "user_id" not in session:
        return redirect(url_for("login"))

    id_carts = request.form.getlist("pilih_produk")
    if not id_carts:
        flash("Pilih produk terlebih dahulu!", "warning")
        return redirect(url_for("cart"))

    placeholders = ",".join(["%s"] * len(id_carts))

    cursor.execute(f"""
        SELECT 
            c.id_cart,
            c.id_produk,
            c.id_varian,
            c.warna,
            c.jumlah,
            d.nama_produk,
            vp.harga,
            vp.nama_varian,
            vd.stok
        FROM cart c
        JOIN data d ON c.id_produk = d.id_produk
        JOIN varian_produk vp ON c.id_varian = vp.id_varian
        JOIN varian_detail vd 
            ON vd.id_varian = c.id_varian 
            AND vd.warna = c.warna
        WHERE c.id_cart IN ({placeholders})
        AND c.id_user = %s
    """, (*id_carts, session["user_id"]))

    items = cursor.fetchall()

    if not items:
        flash("Produk tidak ditemukan.", "danger")
        return redirect(url_for("cart"))

    # 🔥 CEK STOK
    for item in items:
        if item["jumlah"] > item["stok"]:
            flash(
                f"Stok {item['nama_produk']} - {item['nama_varian']} ({item['warna']}) tidak mencukupi!",
                "danger"
            )
            return redirect(url_for("cart"))

    # 🔥 Ambil semua alamat user
    cursor.execute("""
        SELECT * FROM user_addresses
        WHERE id_user = %s
        ORDER BY is_default DESC, id_address DESC
    """, (session["user_id"],))

    all_addresses = cursor.fetchall()

    # 🔥 Default = yang pertama (karena sudah di order DESC)
    default_address = all_addresses[0] if all_addresses else None

    # 🔥 Hitung total
    subtotal = sum(
        (item["jumlah"] or 0) * (item["harga"] or 0)
        for item in items
    )

    admin = 2000
    ongkir = 0

    cursor.execute("""
    SELECT biaya FROM ongkir
    WHERE LOWER(provinsi)=LOWER(%s)
    AND LOWER(kabupaten)=LOWER(%s)
    AND LOWER(kecamatan)=LOWER(%s)
    LIMIT 1
    """, (
        default_address["provinsi"],
        default_address["kabupaten"],
        default_address["kecamatan"]
    ))

    data_ongkir = cursor.fetchone()

    if data_ongkir:
        ongkir = data_ongkir["biaya"]

    total_final = subtotal + admin + ongkir

    # Optional wilayah
    

    qr_code = generate_qr("BANK-VA-12345678")

    with open("static/data/wilayah_sulawesi.json", encoding="utf-8") as f:
         wilayah = json.load(f)

    return render_template(
        "checkout.html",
        items=items,
        subtotal=subtotal,
        admin=admin,
        ongkir=ongkir,
        total_final=total_final,
        id_carts=id_carts,
        wilayah=wilayah,
        qr_code=qr_code,
        default_address=default_address,
        all_addresses=all_addresses,
        selected_address = default_address
    )


@app.route("/get_ongkir", methods=["POST"])
def get_ongkir():

    provinsi = request.json["provinsi"]
    kabupaten = request.json["kabupaten"]
    kecamatan = request.json["kecamatan"]

    cursor.execute("""
        SELECT biaya FROM ongkir
        WHERE provinsi=%s
        AND kabupaten=%s
        AND kecamatan=%s
        LIMIT 1
    """, (provinsi, kabupaten, kecamatan))

    data = cursor.fetchone()

    if data:
        return {"ongkir": data["biaya"]}
    else:
        return {"ongkir": 0}

def hitung_ongkir(provinsi, kabupaten, kecamatan):

    cursor.execute("""
        SELECT biaya 
        FROM ongkir
        WHERE provinsi=%s
        AND kabupaten=%s
        AND kecamatan=%s
        LIMIT 1
    """, (provinsi, kabupaten, kecamatan))

    data = cursor.fetchone()

    if data:
        return data["biaya"]
    else:
        return 25.000


@app.route("/checkout/process", methods=["POST"])
def checkout_process():
    if "user_id" not in session:
        return redirect(url_for("login"))

    try:
        id_user = session["user_id"]

        id_carts = request.form.getlist("pilih_produk")
        if not id_carts:
            flash("Pilih minimal 1 produk!", "warning")
            return redirect(url_for("cart"))

        metode = request.form.get("pembayaran")

        # alamat dipilih user
        id_address = request.form.get("selected_address")

        if not id_address:
            flash("Silakan pilih alamat pengiriman!", "warning")
            return redirect(url_for("checkout"))

        # ambil alamat dari database
        cursor.execute("""
            SELECT * FROM user_addresses
            WHERE id_address=%s AND id_user=%s
        """, (id_address, id_user))

        alamat = cursor.fetchone()

        if not alamat:
            flash("Alamat tidak valid", "danger")
            return redirect(url_for("checkout"))

        # ambil data lokasi
        provinsi = alamat["provinsi"]
        kota = alamat["kabupaten"]
        kecamatan = alamat["kecamatan"]
        alamat_lengkap = alamat["detail_alamat"]
        lat = request.form.get("lat")
        lng = request.form.get("lng")
        alamat_map = request.form.get("alamat_map")

        lat = alamat["lat"]
        lng = alamat["lng"]

        # hitung ongkir
        ongkir = hitung_ongkir(
        alamat["provinsi"],
        alamat["kabupaten"],
        alamat["kecamatan"]
    )

        placeholders = ",".join(["%s"] * len(id_carts))

        cursor.execute(f"""
            SELECT 
                c.id_produk,
                c.id_varian,
                c.warna,
                c.jumlah,
                vp.harga,
                vd.stok
            FROM cart c
            JOIN varian_produk vp ON c.id_varian = vp.id_varian
            JOIN varian_detail vd 
                ON vd.id_varian = c.id_varian
                AND vd.warna = c.warna
            WHERE c.id_cart IN ({placeholders})
            AND c.id_user = %s
        """, (*id_carts, id_user))

        cart_items = cursor.fetchall()

        if not cart_items:
            raise Exception("Data cart tidak ditemukan")

        # cek stok
        for item in cart_items:
            if item["stok"] < item["jumlah"]:
                raise Exception("Stok varian tidak mencukupi")

        subtotal = sum(
            (i["jumlah"] or 0) * (i["harga"] or 0)
            for i in cart_items
        )

        total_all = subtotal + ongkir

        # status pembayaran
        if metode == "TRANSFER":
            kode_billing = generate_billing_code()
            status_pembayaran = "Menunggu Verifikasi"
            status_pesanan = "Menunggu Pembayaran"
        else:
            status_pembayaran = "COD"
            status_pesanan = "Diproses"

        # simpan order
        cursor.execute("""
        INSERT INTO orders (
            id_user,
            provinsi,
            kota,
            alamat_lengkap,
            lat,
            lng,
            alamat_map,
            ongkir,
            total_harga,
            status_pesanan,
            metode_pembayaran,
            kode_billing,
            tanggal
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,NOW())
        """, (
            id_user,
            alamat["provinsi"],
            alamat["kabupaten"],
            alamat["detail_alamat"],
            lat,
            lng,
            alamat_map,
            ongkir,
            total_all,
            status_pesanan,
            metode,
            kode_billing if metode == "TRANSFER" else None
        ))

        id_order = cursor.lastrowid

        # simpan order detail
        for item in cart_items:
            subtotal_item = item["jumlah"] * item["harga"]

            cursor.execute("""
                INSERT INTO order_detail
                (id_order, id_produk, jumlah, harga, subtotal, id_varian)
                VALUES (%s,%s,%s,%s,%s,%s)
            """, (
                id_order,
                item["id_produk"],
                item["jumlah"],
                item["harga"],
                subtotal_item,
                item["id_varian"]
            ))

            # update stok
            cursor.execute("""
                UPDATE varian_detail
                SET stok = stok - %s
                WHERE id_varian = %s
                AND warna = %s
            """, (
                item["jumlah"],
                item["id_varian"],
                item["warna"]
            ))

        # hapus cart
        cursor.execute(
            f"DELETE FROM cart WHERE id_cart IN ({placeholders}) AND id_user=%s",
            (*id_carts, id_user)
        )

        db.commit()

        if metode == "TRANSFER":
            return redirect(url_for("payment_page", order_id=id_order))
        else:
            return redirect(url_for("checkout_success"))

    except Exception as e:
        db.rollback()
        print("CHECKOUT ERROR:", e)
        print("FORM DATA:", request.form)
        print("DATA ALAMAT:", alamat)

        flash(str(e), "danger")
        return redirect(url_for("cart"))

@app.route("/get_addresses")
def get_addresses():

    cursor.execute("""
        SELECT * FROM user_addresses
        WHERE id_user=%s
        ORDER BY is_default DESC
    """,(session["user_id"],))

    return jsonify(cursor.fetchall())

@app.route("/update_address", methods=["POST"])
def update_address():
    if "user_id" not in session:
        return jsonify({"status": "error", "message": "Unauthorized"}), 401

    id_user = session["user_id"]
    id_address = request.form.get("id_address")
    nama = request.form.get("nama")
    no_hp = request.form.get("no_hp")
    provinsi = request.form.get("provinsi")
    kabupaten = request.form.get("kabupaten")
    kecamatan = request.form.get("kecamatan")
    detail = request.form.get("detail")
    kode_pos = request.form.get("kode_pos")

    cursor.execute("""
        UPDATE user_addresses
        SET
            nama_penerima=%s,
            no_hp=%s,
            provinsi=%s,
            kabupaten=%s,
            kecamatan=%s,
            detail_alamat=%s,
            kode_pos=%s
        WHERE id_address=%s AND id_user=%s
    """, (
        nama,
        no_hp,
        provinsi,
        kabupaten,
        kecamatan,
        detail,
        kode_pos,
        id_address,
        id_user
    ))

    db.commit()

    # ambil ongkir dari kecamatan
    cursor.execute("""
        SELECT biaya FROM ongkir
        WHERE kecamatan=%s
        LIMIT 1
    """, (kecamatan,))

    ongkir = cursor.fetchone()
    biaya = ongkir["biaya"] if ongkir else 0

    return jsonify({
        "status": "success",
        "ongkir": biaya
    })

@app.route("/add_address", methods=["POST"])
def add_address():

    cursor.execute("""
        INSERT INTO user_addresses
        (id_user,nama_penerima,no_hp,provinsi,kota,kecamatan,alamat_lengkap,lat,lng,is_default)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,0)
    """,(
        session["user_id"],
        request.form["nama"],
        request.form["hp"],
        request.form["provinsi"],
        request.form["kota"],
        request.form["kecamatan"],
        request.form["alamat"],
        request.form["lat"],
        request.form["lng"]
    ))

    db.commit()

    return jsonify({"status":"success"})

@app.route("/edit_address", methods=["POST"])
def edit_address():

    cursor.execute("""
        UPDATE user_addresses
        SET
            nama_penerima=%s,
            no_hp=%s,
            provinsi=%s,
            kota=%s,
            kecamatan=%s,
            alamat_lengkap=%s
        WHERE id_address=%s AND id_user=%s
    """,(
        request.form["nama"],
        request.form["hp"],
        request.form["provinsi"],
        request.form["kota"],
        request.form["kecamatan"],
        request.form["alamat"],
        request.form["id_address"],
        session["user_id"]
    ))

    db.commit()

    return jsonify({"status":"updated"})

@app.route("/set_default_address", methods=["POST"])
def set_default_address():

    id_address = request.form["id_address"]

    cursor.execute("""
        UPDATE user_addresses
        SET is_default=0
        WHERE id_user=%s
    """,(session["user_id"],))

    cursor.execute("""
        UPDATE user_addresses
        SET is_default=1
        WHERE id_address=%s
    """,(id_address,))

    db.commit()

    return jsonify({"status":"success"})
    
@app.route("/alamat/tambah", methods=["GET", "POST"])
def tambah_alamat():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    if request.method == "POST":
        id_user = session["user_id"]
        negara = request.form.get("negara")
        provinsi = request.form.get("provinsi")
        kota = request.form.get("kota")
        kecamatan = request.form.get("kecamatan")
        kode_pos = request.form.get("kode_pos")
        alamat_lengkap = request.form.get("alamat_lengkap")
        lat = request.form.get("lat")
        lng = request.form.get("lng")
        selected_address_id = request.form.get("selected_address")

        # set semua alamat lama jadi non default
        cursor.execute("""
            UPDATE user_addresses
            SET is_default = 0
            WHERE id_user = %s
        """, (id_user,))

        # insert alamat baru
        cursor.execute("""
            INSERT INTO user_addresses
            (id_user, negara, provinsi, kota, kecamatan,
             kode_pos, alamat_lengkap, lat, lng, is_default)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,1)
        """, (
            id_user, negara, provinsi, kota,
            kecamatan, kode_pos,
            alamat_lengkap, lat, lng
        ))

        db.commit()
        return redirect(url_for("checkout"))

    return render_template("tambah_alamat.html")

@app.route("/checkout/success")
def checkout_success():
    return render_template("checkout_success.html")



@app.route("/simpan-alamat", methods=["POST"])
def simpan_alamat():
    if "user_id" not in session:
        return redirect(url_for("login"))

    provinsi = request.form["provinsi"]
    kabupaten = request.form["kabupaten"]
    kecamatan = request.form["kecamatan"]
    alamat_lengkap = request.form["alamat_lengkap"]

    # reset default lama
    cursor.execute("""
        UPDATE user_addresses
        SET is_default = 0
        WHERE id_user = %s
    """, (session["user_id"],))

    # insert baru jadi default
    cursor.execute("""
        INSERT INTO user_addresses
        (id_user, provinsi, kabupaten, kecamatan, alamat_lengkap, is_default)
        VALUES (%s,%s,%s,%s,%s,1)
    """, (
        session["user_id"],
        provinsi,
        kabupaten,
        kecamatan,
        alamat_lengkap
    ))

    db.commit()

    flash("Alamat berhasil diperbarui", "success")
    return redirect(url_for("checkout"))

#pembayaran
@app.route("/payment/<int:order_id>", methods=["GET", "POST"])
def payment_page(order_id):
    if "user_id" not in session:
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT * FROM orders
        WHERE id_order=%s AND id_user=%s
    """, (order_id, session["user_id"]))
    order = cursor.fetchone()

    if not order:
        flash("Pesanan tidak ditemukan", "danger")
        return redirect(url_for("cart"))

    # upload bukti bayar
    if request.method == "POST":
        bukti = request.files.get("bukti")

        if not bukti:
            flash("Upload bukti pembayaran terlebih dahulu", "warning")
            return redirect(request.url)

        filename = secure_filename(bukti.filename)
        bukti.save(f"static/bukti/{filename}")

        cursor.execute("""
            UPDATE orders
            SET status_pembayaran=%s,
                bukti_pembayaran=%s
            WHERE id_order=%s
        """, ("Menunggu Verifikasi", filename, order_id))
        db.commit()

        flash("Bukti pembayaran berhasil dikirim", "success")
        return redirect(url_for("checkout_success"))
    admin = 2000
    subtotal = order["total_harga"] - order["ongkir"] - admin
    return render_template("payment.html", order=order,subtotal=subtotal,admin=admin)

@app.route("/admin/ongkir")
def admin_ongkir():
    cursor.execute("""
        SELECT *
        FROM ongkir
        ORDER BY provinsi, kabupaten, kecamatan
    """)
    data_ongkir = cursor.fetchall()

    return render_template(
        "admin/admin_ongkir.html",
        data_ongkir=data_ongkir
    )

@app.route("/admin/ongkir/tambah", methods=["GET", "POST"])
def tambah_ongkir():
    if request.method == "POST":
        provinsi = request.form.get("provinsi")
        kabupaten = request.form.get("kabupaten")
        kecamatan = request.form.get("kecamatan")
        biaya = request.form.get("biaya")

        # Validasi sederhana
        if not provinsi or not kabupaten or not kecamatan or not biaya:
            return "Semua field harus diisi!"

        cursor.execute("""
            INSERT INTO ongkir (provinsi, kabupaten, kecamatan, biaya)
            VALUES (%s, %s, %s, %s)
        """, (provinsi, kabupaten, kecamatan, biaya))

        db.commit()

        return redirect(url_for("admin_ongkir"))

    return render_template("admin/tambah_ongkir.html")

@app.route("/admin/ongkir/edit/<int:id>", methods=["GET", "POST"])
def edit_ongkir(id):
    if request.method == "POST":
        provinsi = request.form.get("provinsi")
        kabupaten = request.form.get("kabupaten")
        kecamatan = request.form.get("kecamatan")
        biaya = request.form.get("biaya")

        cursor.execute("""
            UPDATE ongkir
            SET provinsi=%s,
                kabupaten=%s,
                kecamatan=%s,
                biaya=%s
            WHERE id_ongkir=%s
        """, (provinsi, kabupaten, kecamatan, biaya, id))

        db.commit()

        return redirect(url_for("admin_ongkir"))

    # Ambil data lama untuk ditampilkan di form
    cursor.execute("SELECT * FROM ongkir WHERE id_ongkir=%s", (id,))
    data = cursor.fetchone()

    return render_template("admin/edit_ongkir.html", data=data)

@app.route("/admin/ongkir/hapus/<int:id>")
def hapus_ongkir(id):
    cursor.execute("DELETE FROM ongkir WHERE id_ongkir=%s", (id,))
    db.commit()

    return redirect(url_for("admin_ongkir"))

@app.route("/admin/orders")
def admin_orders():
    cursor.execute(
        """
        SELECT o.*, u.nama 
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        ORDER BY o.id_order DESC
    """
    )
    orders = cursor.fetchall()
    return render_template("admin/admin_orders.html", orders=orders)


@app.route("/admin/orders/<int:id_order>")
def admin_order_detail(id_order):

    cursor.execute("""
        SELECT o.*, u.nama, u.email
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        WHERE o.id_order = %s
    """, (id_order,))
    order = cursor.fetchone()

    cursor.execute("""
        SELECT d.*, p.nama_produk, p.gambar
        FROM order_detail d
        JOIN data p ON d.id_produk = p.id_produk
        WHERE d.id_order = %s
    """, (id_order,))
    items = cursor.fetchall()

    cursor.execute("""
        SELECT *
        FROM order_status_history
        WHERE id_order = %s
        ORDER BY created_at DESC
    """, (id_order,))
    logs = cursor.fetchall()

    admin = 2000  
    ongkir = order["ongkir"] or 0
    total = order["total_harga"] or 0
    subtotal = total - ongkir - admin

    return render_template(
        "admin/admin_order_detail.html",
        order=order,
        items=items,
        logs=logs,
        subtotal=subtotal,
        admin=admin
    )

@app.route("/admin/orders/<int:id_order>/invoice")
def admin_order_invoice(id_order):
    cursor = db.cursor(dictionary=True)

    # Ambil data order + user
    cursor.execute("""
        SELECT o.*, u.nama as user_nama, u.email as user_email
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        WHERE o.id_order = %s
    """, (id_order,))
    order = cursor.fetchone()

    # Ambil detail order + nama produk
    cursor.execute("""
        SELECT 
    d.id_order,
    d.id_produk,
    d.id_varian,
    d.id_detail,
    d.jumlah,
    d.harga,
    d.subtotal,
    p.nama_produk,
    vp.nama_varian,
    vd.warna
FROM order_detail d
LEFT JOIN data p ON d.id_produk = p.id_produk
LEFT JOIN varian_produk vp ON d.id_varian = vp.id_varian
LEFT JOIN varian_detail vd ON d.id_detail = vd.id_detail
WHERE d.id_order = %s
    """, (id_order,))
    items = cursor.fetchall()

    items_lower = []
    for it in items:
     items_lower.append({
        "id_produk": it["id_produk"],
        "nama_produk": it["nama_produk"],
        "nama_varian": it["nama_varian"],
        "warna": it["warna"],
        "jumlah": it["jumlah"],
        "harga": it["harga"],
        "subtotal": it["subtotal"]
    })

    return render_template(
        "admin/admin_order_invoice.html",
        order=order,
        items=items_lower
    )


@app.route("/admin/orders/update_status/<int:id_order>", methods=["POST"])
def admin_update_order_status(id_order):
    status_baru = request.form.get("status")

    # Ambil status lama
    cursor.execute("SELECT status_pesanan FROM orders WHERE id_order=%s", (id_order,))
    old = cursor.fetchone()["status_pesanan"]

    # Update tabel orders
    cursor.execute(
        """
        UPDATE orders
        SET status_pesanan = %s
        WHERE id_order = %s
    """,
        (status_baru, id_order),
    )
    db.commit()

    # Riwayat update
    note = "Status diperbarui oleh admin"

    cursor.execute(
        """
        INSERT INTO order_status_history (id_order, status_lama, status_baru, note)
        VALUES (%s, %s, %s, %s)
    """,
        (id_order, old, status_baru, note),
    )
    db.commit()

    flash("Status pesanan berhasil diperbarui!", "success")
    return redirect(url_for("admin_order_detail", id_order=id_order))

#evaluasi sistem
@app.route('/admin/evaluasi')
def admin_evaluasi():
    if session.get('role') != 'admin':
        return redirect(url_for('login'))

    cursor.execute("""
        SELECT id_user, nama 
        FROM users 
        WHERE role != 'admin'
        ORDER BY id_user ASC
    """)
    users = cursor.fetchall()

    return render_template('admin/evaluasi/index.html', users=users)
from flask import session, redirect, url_for, render_template
from collections import defaultdict
import math


def compute_adjusted_cosine(user_items):
    """Hitung Adjusted Cosine Similarity antar item"""
    item_user_ratings = defaultdict(dict)
    for user, items in user_items.items():
        for item, rating in items.items():
            item_user_ratings[item][user] = rating

    sim = defaultdict(dict)
    for i in item_user_ratings:
        for j in item_user_ratings:
            if i == j:
                continue
            common_users = set(item_user_ratings[i].keys()) & set(item_user_ratings[j].keys())
            if not common_users:
                continue
            # mean rating per user
            numerator = 0
            denom_i = 0
            denom_j = 0
            for u in common_users:
                r_i = item_user_ratings[i][u]
                r_j = item_user_ratings[j][u]
                mean_u = sum(user_items[u].values()) / len(user_items[u])
                numerator += (r_i - mean_u) * (r_j - mean_u)
                denom_i += (r_i - mean_u) ** 2
                denom_j += (r_j - mean_u) ** 2
            if denom_i == 0 or denom_j == 0:
                continue
            sim[i][j] = numerator / math.sqrt(denom_i * denom_j)
    return sim

def generate_prediction_for_eval(user_id, train_matrix, similarity, top_k=5):
    """Prediksi top-K item untuk user (hanya item belum di-rate)"""
    user_ratings = train_matrix.get(user_id, {})
    if not user_ratings:
        return []

    user_mean = sum(user_ratings.values()) / len(user_ratings)
    scores = {}

    for item_j in similarity:
        # Skip item yang sudah di-rate
        if item_j in user_ratings:
            continue

        num, den = 0, 0
        for item_i, rating in user_ratings.items():
            sim = similarity.get(item_j, {}).get(item_i, 0)
            num += sim * (rating - user_mean)
            den += abs(sim)

        if den == 0:
            continue

        pred = user_mean + (num / den)
        pred = max(1, min(5, pred))  # prediksi 1-5
        scores[item_j] = pred

    # Urutkan berdasarkan prediksi tertinggi
    ranked = sorted(scores.items(), key=lambda x: x[1], reverse=True)
    ranked = ranked[:top_k]  # pastikan ini unik
    return [r[0] for r in ranked]

import copy
from collections import defaultdict

# -----------------------------
# 1️⃣ Load User-Item Matrix
# -----------------------------
def load_user_item_matrix():
    cursor.execute("SELECT id_user, id_produk, rating FROM rating WHERE rating IS NOT NULL")
    rows = cursor.fetchall()

    user_items = defaultdict(dict)
    for r in rows:
        if r["rating"] is not None:
            user_items[r["id_user"]][r["id_produk"]] = r["rating"]

    return user_items

# -----------------------------
# 2️⃣ Weighted IBCF Prediction (mean-centered)
# -----------------------------
def generate_weighted_prediction(user_id, train_matrix, similarity, top_k=5, return_detail=False):
    user_ratings = train_matrix.get(user_id, {})
    if not user_ratings:
        return []

    user_mean = sum(user_ratings.values()) / len(user_ratings)
    scores = {}
    detail = []

    for item_j in similarity:
        if item_j in user_ratings:
            continue

        num, den = 0, 0
        for item_i, rating in user_ratings.items():
            sim = similarity.get(item_j, {}).get(item_i, 0)
            num += sim * (rating - user_mean)
            den += abs(sim)

        if den == 0:
            continue

        pred = user_mean + (num / den)
        pred = max(1, min(5, pred))
        scores[item_j] = pred

        if return_detail:
            detail.append({"item": item_j, "prediksi_rating": round(pred, 3)})

    ranked = sorted(scores.items(), key=lambda x: x[1], reverse=True)[:top_k]
    ranked = list(dict.fromkeys([r[0] for r in ranked]))  # hapus duplikat

    return (ranked, detail) if return_detail else ranked

# -----------------------------
# 3️⃣ Relevan Item User
# -----------------------------
def get_relevant_items(user_id, threshold=4):
    user_items = load_user_item_matrix()
    if user_id not in user_items:
        return []
    return [item for item, rating in user_items[user_id].items() if rating is not None and rating >= threshold]

# -----------------------------
# 4️⃣ Leave-One-Out Evaluation (MAE + Precision/Recall)
# -----------------------------
def hitung_mae(user_id):
    user_items = load_user_item_matrix()
    similarity = compute_adjusted_cosine(user_items)
    
    if user_id not in user_items:
        return 0.0

    user_ratings = user_items[user_id]
    if len(user_ratings) < 2:
        return 0.0

    user_mean = sum(user_ratings.values()) / len(user_ratings)
    errors = []

    for item_i, actual_rating in user_ratings.items():
        num, den = 0, 0
        for item_j, rating_j in user_ratings.items():
            if item_i == item_j:
                continue
            sim = similarity.get(item_i, {}).get(item_j, 0)
            num += sim * (rating_j - user_mean)
            den += abs(sim)
        if den == 0:
            continue
        predicted_rating = user_mean + (num / den)
        predicted_rating = max(1, min(5, predicted_rating))
        errors.append(abs(actual_rating - predicted_rating))

    if not errors:
        return 0.0
    return sum(errors) / len(errors)

def hitung_precision_recall_loo(user_id, top_k=5, threshold=4):
    user_items = load_user_item_matrix()
    if user_id not in user_items:
        return 0.0, 0.0

    relevant_items = get_relevant_items(user_id, threshold)
    if not relevant_items:
        return 0.0, 0.0

    precision_list = []
    recall_list = []

    for test_item in relevant_items:
        # deepcopy agar LOO aman
        train_items = {k: v for k, v in user_items[user_id].items() if k != test_item}
        train_matrix = copy.deepcopy(user_items)
        train_matrix[user_id] = train_items

        similarity = compute_adjusted_cosine(train_matrix)
        rekom = generate_weighted_prediction(user_id, train_matrix, similarity, top_k=top_k)

        tp = 1 if test_item in rekom else 0
        precision_list.append(tp / top_k)
        recall_list.append(tp / 1)

    precision = (sum(precision_list) / len(precision_list)) 
    recall = (sum(recall_list) / len(recall_list)) 

    return precision, recall

@app.route('/admin/evaluasi/<int:user_id>')
def detail_evaluasi(user_id):
    if session.get('role') != 'admin':
        return redirect(url_for('login'))

    # 1️⃣ Data User (TIDAK ambil jika role admin)
    cursor.execute("""
        SELECT * FROM users 
        WHERE id_user = %s 
        AND role != 'admin'
    """, (user_id,))
    user = cursor.fetchone()

    # Kalau ternyata user adalah admin → redirect
    if not user:
        return redirect(url_for('admin_evaluasi'))  # sesuaikan dengan route daftar evaluasi kamu

    # 2️⃣ Produk Dibeli
    cursor.execute("""
        SELECT d.nama_produk
        FROM orders o
        JOIN order_detail od ON o.id_order = od.id_order
        JOIN data d ON od.id_produk = d.id_produk
        WHERE o.id_user = %s
    """, (user_id,))
    purchased_products = cursor.fetchall()

    # 3️⃣ Rekomendasi
    user_items = load_user_item_matrix()
    similarity = compute_adjusted_cosine(user_items)
    rekomendasi = recommend_for_user(cursor, user_id, similarity, user_items, N=5)

    # 4️⃣ Evaluasi
    mae = hitung_mae(user_id)
    precision, recall = hitung_precision_recall_loo(user_id, top_k=5)

    return render_template(
        'admin/evaluasi/detail.html',
        user=user,
        user_id=user_id,
        purchased_products=purchased_products,
        rekomendasi=rekomendasi,
        mae=round(mae, 4),
        precision=round(precision, 2),
        recall=round(recall, 2)
    )

   # debug

def evaluasi_user(user_id, nama):
    mae = hitung_mae(user_id)
    precision, recall = hitung_precision_recall_loo_fix(user_id, top_k=5)

    hasil = {
        "Nama User": nama,
        "MAE": round(mae, 4),
        "Precision@5": precision,
        "Recall@5": recall
    }

    return hasil
def print_evaluasi_terminal(hasil):
    print("\n===================================")
    print(" Evaluasi Sistem Rekomendasi ")
    print("===================================")

    max_len = max(len(k) for k in hasil.keys()) + 2

    for key, value in hasil.items():
        print(f"{key:<{max_len}} : {value}")

    print("===================================\n")

@app.route("/evaluasi_terminal")
def evaluasi_terminal():
    user_id = session.get("user_id")
    nama = session.get("nama")
    if not user_id:
        return "User belum login"

    mae = hitung_mae(user_id)
    precision, recall = hitung_precision_recall_loo_fix(user_id, top_k=5)

    return f"""
    <h2>Evaluasi Sistem Rekomendasi</h2>
    <p>Nama       : {nama}</p>
    <p>MAE        : {round(mae, 4)}</p>
    <p>Precision@5: {round(precision, 2)}</p>
    <p>Recall@5   : {round(recall, 2)}</p>
    """


import math
from collections import defaultdict

def print_evaluasi_terminal_sederhana(user_id, nama):
    """Cetak evaluasi user ke terminal (sederhana)"""
    mae = hitung_mae(user_id)
    precision, recall = hitung_precision_recall_loo_fix(user_id, top_k=5)

    print("\n==============================")
    print(f"Nama       : {nama}")
    print(f"MAE        : {round(mae, 4)}")
    print(f"Precision@5: {round(precision, 2)}")
    print(f"Recall@5   : {round(recall, 2)}")
    print("==============================\n")



def generate_ibcf_recommendation(user_id, top_k=5):
    user_items = load_user_item_matrix()
    similarity = compute_adjusted_cosine(user_items)

    if user_id not in user_items:
        return []

    user_ratings = user_items[user_id]

    if len(user_ratings) < 2:
        return []

    user_mean = sum(user_ratings.values()) / len(user_ratings)

    scores = {}

    for item_j in similarity:
        if item_j in user_ratings:
            continue

        num = 0
        den = 0

        for item_i, rating in user_ratings.items():
            sim = similarity.get(item_j, {}).get(item_i, 0)

            num += sim * (rating - user_mean)
            den += abs(sim)

        if den == 0:
            continue

        pred = user_mean + (num / den)
        pred = max(1, min(5, pred))

        scores[item_j] = pred

    ranked = sorted(scores.items(), key=lambda x: x[1], reverse=True)[:top_k]
    return list(dict.fromkeys([r[0] for r in ranked]))  # hapus duplikasi




def cek_item_relevan(user_id, threshold=4):
    user_items = load_user_item_matrix()

    if user_id not in user_items:
        return []

    user_ratings = user_items[user_id]

    relevant_items = [
        item for item, rating in user_ratings.items()
        if rating >= threshold
    ]

    return relevant_items

print("=== ire ===\n")
print(cek_item_relevan(16))

@app.route("/admin/orders/verify_payment/<int:id_order>", methods=["POST"])
def admin_verify_payment(id_order):
    aksi = request.form.get("aksi")

    if aksi == "terima":
        status_bayar = "Terverifikasi"
        status_pesanan = "diproses/packing"
        note = "Pembayaran diverifikasi oleh admin"

    elif aksi == "tolak":
        status_bayar = "Ditolak"
        status_pesanan = "menunggu pembayaran"
        note = "Pembayaran ditolak oleh admin"

    else:
        flash("Aksi tidak valid", "danger")
        return redirect(url_for("admin_order_detail", id_order=id_order))

    # update orders
    cursor.execute("""
        UPDATE orders
        SET status_pembayaran=%s,
            status_pesanan=%s
        WHERE id_order=%s
    """, (status_bayar, status_pesanan, id_order))
    db.commit()

    # simpan ke riwayat
    cursor.execute("""
        INSERT INTO order_status_history
        (id_order, status_lama, status_baru, note)
        VALUES (%s, %s, %s, %s)
    """, (
        id_order,
        "Menunggu Verifikasi",
        status_bayar,
        note
    ))
    db.commit()

    flash("Status pembayaran berhasil diperbarui", "success")
    return redirect(url_for("admin_order_detail", id_order=id_order))

@app.route("/admin/orders/cancel/<int:id_order>", methods=["POST"])
def admin_cancel_order(id_order):

    cursor.execute(
        """
        UPDATE orders 
        SET status_pesanan='dibatalkan'
        WHERE id_order=%s
    """,
        (id_order,),
    )
    db.commit()

    flash("Pesanan berhasil dibatalkan!", "danger")
    return redirect(url_for("admin_order_detail", id_order=id_order))


def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("role") != "admin":
            flash("Akses ditolak.", "danger")
            return redirect(url_for("login"))
        return f(*args, **kwargs)

    return decorated_function


@app.route("/admin")
@app.route("/admin/dashboard")
def admin_dashboard():
    # total produk
    cursor.execute("SELECT COUNT(*) AS total FROM data")
    total_produk = cursor.fetchone()["total"]

    # total brand
    cursor.execute("SELECT COUNT(*) AS total FROM brand")
    total_brand = cursor.fetchone()["total"]

    # total user
    cursor.execute("SELECT COUNT(*) AS total FROM users")
    total_user = cursor.fetchone()["total"]

    # pesanan terbaru
    cursor.execute(
        """
        SELECT o.*, u.nama 
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        ORDER BY o.id_order DESC
        LIMIT 5
    """
    )
    pesanan_terbaru = cursor.fetchall()

    
    return render_template(
        "admin/admin_dashboard.html",
        total_produk=total_produk,
        total_brand=total_brand,
        total_user=total_user,
        pesanan_terbaru=pesanan_terbaru,
    )


@app.route("/remove_cart/<int:id_cart>", methods=["POST"])
def remove_cart(id_cart):
    id_user = session.get("user_id")
    cursor.execute(
        "DELETE FROM cart WHERE id_cart = %s AND id_user = %s", (id_cart, id_user)
    )
    db.commit()
    flash("Produk dihapus dari keranjang.", "info")
    return redirect(url_for("cart"))


@app.route("/cart")
def cart():
    id_user = session.get("user_id")
    if not id_user:
        flash("Silakan login terlebih dahulu.", "warning")
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT
    c.id_cart,
    c.id_produk,
    c.id_varian,
    c.jumlah,
    d.nama_produk,
    d.merek,
    d.gambar,
    COALESCE(vp.harga, 0) AS harga,
    COALESCE(vp.nama_varian, '') AS nama_varian,
    c.warna,
    (c.jumlah * COALESCE(vp.harga, 0)) AS total_harga
FROM cart c
JOIN data d ON c.id_produk = d.id_produk
LEFT JOIN varian_produk vp ON c.id_varian = vp.id_varian
WHERE c.id_user = %s
    """, (id_user,))

    items = cursor.fetchall()

    # total jumlah item di cart
    cursor.execute("SELECT SUM(jumlah) AS total FROM cart WHERE id_user=%s", (id_user,))
    jumlah_cart = cursor.fetchone()["total"] or 0

    return render_template("cart.html", items=items, jumlah_cart=jumlah_cart)


@app.route("/hapus_dari_cart/<int:id_cart>", methods=["POST", "GET"])
def hapus_dari_cart(id_cart):
    id_user = session.get("user_id")
    if not id_user:
        flash("Silakan login terlebih dahulu.", "warning")
        return redirect(url_for("login"))

    # Hapus item dari keranjang
    cursor.execute(
        "DELETE FROM cart WHERE id_cart = %s AND id_user = %s", (id_cart, id_user)
    )
    db.commit()

    flash("Produk telah dihapus dari keranjang.", "success")
    return redirect(url_for("cart"))

@app.route("/logout")
def logout():
    session.clear()
    flash("Anda berhasil logout.", "info")
    return redirect(url_for("login_user"))

@app.route("/admin/produk")
def admin_produk():
    if session.get("role") != "admin":
        flash("Akses ditolak.", "danger")
        return redirect(url_for("login"))

    query = """
SELECT 
    d.*,

    -- ambil harga termurah dari semua varian
    MIN(vp.harga) AS harga,

    -- jumlahkan semua stok dari kombinasi varian + warna
    COALESCE(SUM(vd.stok), 0) AS stok,

    ROUND(AVG(r.rating), 1) AS rata_rating,
    COUNT(DISTINCT r.id) AS total_review

FROM data d
LEFT JOIN varian_produk vp ON d.id_produk = vp.id_produk
LEFT JOIN varian_detail vd ON vp.id_varian = vd.id_varian
LEFT JOIN rating r ON d.id_produk = r.id_produk

GROUP BY d.id_produk
ORDER BY d.id_produk DESC
"""


    cursor.execute(query)
    produk = cursor.fetchall()

    return render_template(
        "admin/admin_produk.html",
        produk=produk,
        current_date=datetime.now().strftime("%d-%m-%Y"),
    )



from werkzeug.utils import secure_filename

@app.route("/admin/produk/tambah", methods=["GET", "POST"])
def tambah_produk():
    if session.get("role") != "admin":
        flash("Akses ditolak.", "danger")
        return redirect(url_for("login_user"))

    if request.method == "POST":

        # ================== AMBIL DATA PRODUK ==================
        nama_produk = request.form.get("nama_produk")
        merek = request.form.get("merek")
        spesifikasi = request.form.get("spesifikasi")
        baterai = request.form.get("baterai")
        id_brand = request.form.get("id_brand")

        chipset = request.form.get("chipset")
        layar = request.form.get("layar")
        kamera = request.form.get("kamera")
        os_system = request.form.get("os")
        fitur = request.form.get("fitur")

        # ================== UPLOAD GAMBAR UTAMA ==================
        file_gambar = request.files.get("gambar")
        if not file_gambar or file_gambar.filename == "":
            flash("Gambar utama wajib diupload!", "danger")
            return redirect(request.url)

        filename = secure_filename(file_gambar.filename)
        save_path = os.path.join(app.static_folder, "img", filename)
        file_gambar.save(save_path)
        gambar_utama = "img/" + filename

        # ================== SIMPAN PRODUK ==================
        if id_brand:
            cursor.execute("""
            INSERT INTO data 
            (nama_produk, merek, spesifikasi, baterai, chipset, layar, kamera, os, fitur, gambar, id_brand)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
             """, (nama_produk,merek,spesifikasi,baterai,chipset,layar,kamera,os_system,fitur,gambar_utama,id_brand))
        else:
            cursor.execute("""
            INSERT INTO data
            (nama_produk, merek, spesifikasi, baterai, chipset, layar, kamera, os, fitur, gambar)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (nama_produk,merek, spesifikasi,  baterai,chipset,layar,kamera,os_system,fitur,gambar_utama))

        db.commit()
        id_produk = cursor.lastrowid

        # ================== LOOP SEMUA VARIAN ==================
        for key in request.form:
            if key.startswith("ram_"):
                index = key.split("_")[1]

                ram = request.form.get(f"ram_{index}")
                storage = request.form.get(f"storage_{index}")
                harga = request.form.get(f"harga_{index}")

                nama_varian = f"{ram}GB / {storage}GB"

                cursor.execute("""
                    INSERT INTO varian_produk (id_produk, nama_varian, harga)
                    VALUES (%s, %s, %s)
                """, (id_produk, nama_varian, harga))

                id_varian = cursor.lastrowid

                # ================== WARNA PER VARIAN ==================
                warna_list = request.form.getlist(f"warna_{index}[]")
                stok_list = request.form.getlist(f"stok_{index}[]")

                for w, s in zip(warna_list, stok_list):
                    cursor.execute("""
                        INSERT INTO varian_detail (id_varian, warna, stok)
                        VALUES (%s, %s, %s)
                    """, (id_varian, w, s))

        db.commit()

        # ================== SIMPAN GAMBAR DETAIL (MAX 3) ==================
        gambar_detail_list = request.files.getlist("gambar_detail")

        for file in gambar_detail_list[:3]:
            if file and file.filename != "":
                filename = secure_filename(file.filename)
                save_path = os.path.join(app.static_folder, "img", filename)
                file.save(save_path)

                cursor.execute("""
                    INSERT INTO produk_gambar (id_produk, gambar)
                    VALUES (%s, %s)
                """, (id_produk, "img/" + filename))

        db.commit()

        flash("Produk berhasil ditambahkan!", "success")
        return redirect(url_for("admin_produk"))

    # ================== LOAD BRAND ==================
    cursor.execute("SELECT * FROM brand ORDER BY nama_brand ASC")
    brands = cursor.fetchall()

    return render_template("admin/tambah_produk.html", brands=brands)


@app.route("/admin/produk/edit/<int:id_produk>", methods=["GET", "POST"])
def edit_produk(id_produk):
    if session.get("role") != "admin":
        flash("Akses ditolak.", "danger")
        return redirect(url_for("login"))

    # ========================
    # AMBIL DATA PRODUK
    # ========================
    cursor.execute("SELECT * FROM data WHERE id_produk=%s", (id_produk,))
    produk = cursor.fetchone()

    cursor.execute("""
        SELECT 
            vp.id_varian,
            vp.nama_varian,
            vp.harga,
            vd.id_detail,
            vd.warna,
            vd.stok
        FROM varian_produk vp
        LEFT JOIN varian_detail vd 
            ON vp.id_varian = vd.id_varian
        WHERE vp.id_produk = %s
        ORDER BY vp.id_varian
    """, (id_produk,))
    varian_data = cursor.fetchall()

    cursor.execute("SELECT id_brand, nama_brand FROM brand")
    semua_brand = cursor.fetchall()

    # ========================
    # UPDATE DATA
    # ========================
    if request.method == "POST":

        nama = request.form["nama_produk"]
        id_brand = request.form["id_brand"]
        spesifikasi = request.form["spesifikasi"]
        baterai = request.form["baterai"]
        chipset = request.form.get("chipset")
        layar = request.form.get("layar")
        kamera = request.form.get("kamera")
        os = request.form.get("os")
        fitur = request.form.get("fitur")

        # Update produk utama
        cursor.execute("""
    UPDATE data 
    SET nama_produk=%s,
        id_brand=%s,
        spesifikasi=%s,
        baterai=%s,
        chipset=%s,
        layar=%s,
        kamera=%s,
        os=%s,
        fitur=%s
    WHERE id_produk=%s
""", (
    nama,
    id_brand,
    spesifikasi,
    baterai,
    chipset,
    layar,
    kamera,
    os,
    fitur,
    id_produk
))

        # ========================
        # UPDATE VARIAN PRODUK
        # ========================
        id_varian_list = request.form.getlist("id_varian[]")
        nama_varian_list = request.form.getlist("nama_varian[]")
        harga_varian_list = request.form.getlist("harga_varian[]")

        for i in range(len(id_varian_list)):
            cursor.execute("""
                UPDATE varian_produk
                SET nama_varian=%s,
                    harga=%s
                WHERE id_varian=%s
            """, (
                nama_varian_list[i],
                harga_varian_list[i],
                id_varian_list[i]
            ))

        # ========================
        # UPDATE VARIAN DETAIL (WARNA & STOK)
        # ========================
        id_detail_list = request.form.getlist("id_detail[]")
        warna_list = request.form.getlist("warna[]")
        stok_list = request.form.getlist("stok_warna[]")

        for i in range(len(id_detail_list)):
            cursor.execute("""
                UPDATE varian_detail
                SET warna=%s,
                    stok=%s
                WHERE id_detail=%s
            """, (
                warna_list[i],
                stok_list[i],
                id_detail_list[i]
            ))

        db.commit()

        flash("Produk berhasil diperbarui!", "success")
        return redirect(url_for("admin_produk"))

    return render_template(
        "admin/edit_produk.html",
        produk=produk,
        semua_brand=semua_brand,
        varian_data=varian_data
    )

@app.route("/admin/produk/hapus/<int:id_produk>")
def hapus_produk(id_produk):
    if session.get("role") != "admin":
        flash("Akses ditolak.", "danger")
        return redirect(url_for("login"))

    cursor.execute("DELETE FROM data WHERE id_produk = %s", (id_produk,))
    db.commit()
    flash("Produk berhasil dihapus!", "success")
    return redirect(url_for("admin_produk"))


@app.route("/update_jumlah_cart", methods=["POST"])
def update_jumlah_cart():
    id_cart = request.form["id_cart"]
    jumlah = request.form["jumlah"]
    cursor.execute("UPDATE cart SET jumlah = %s WHERE id_cart = %s", (jumlah, id_cart))
    db.commit()
    flash("Jumlah produk diperbarui!", "success")
    return redirect(url_for("cart"))


@app.route("/admin/tambah_warna/<int:id_produk>", methods=["GET", "POST"])
def tambah_warna(id_produk):
    if request.method == "POST":
        warna = request.form["warna"]
        stok = request.form["stok"]
        cursor.execute(
            "INSERT INTO varian_warna (id_produk, warna, stok) VALUES (%s, %s, %s)",
            (id_produk, warna, stok),
        )
        db.commit()
        flash("Warna berhasil ditambahkan!", "success")
        return redirect(url_for("admin/admin_produk"))

    cursor.execute("SELECT nama_produk FROM data WHERE id_produk = %s", (id_produk,))
    produk = cursor.fetchone()
    return render_template("admin/admin_tambah_warna.html", produk=produk)


UPLOAD_FOLDER = "static/uploads"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

# tambah produk
@app.route("/admin/tambah_produk", methods=["GET", "POST"])
def admin_tambah_produk():
    if request.method == "POST":
        nama_produk = request.form["nama_produk"]
        merek = request.form["merek"]
        spesifikasi = request.form["spesifikasi"]
        harga = request.form["harga"]
        stok = request.form["stok"]

        # UPLOAD GAMBAR 
        file = request.files["gambar"]
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config["UPLOAD_FOLDER"], filename)
        file.save(filepath)

        # SIMPAN KE TABEL DATA 
        sql_insert_produk = """
            INSERT INTO data (nama_produk, merek, spesifikasi, harga, stok, gambar)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        val = (nama_produk, merek, spesifikasi, harga, stok, filename)
        cursor.execute(sql_insert_produk, val)
        db.commit()

        # Ambil ID produk yang baru saja disimpan
        id_produk = cursor.lastrowid

        #  SIMPAN VARIAN WARNA 
        warna_list = request.form.getlist("warna[]")
        stok_warna_list = request.form.getlist("stok[]")

        for w, s in zip(warna_list, stok_warna_list):
            cursor.execute(
                "INSERT INTO varian_warna (id_produk, warna, stok_warna) VALUES (%s, %s, %s)",
                (id_produk, w, s),
            )
        db.commit()

        flash("Produk berhasil ditambahkan!", "success")
        return redirect(url_for("admin_produk"))

    return render_template("admin_add_produk.html")

def load_user_items(cursor):
    cursor.execute("""
        SELECT o.id_user, od.id_produk, 
               COALESCE(r.rating, 3) AS score
        FROM order_detail od
        JOIN orders o ON od.id_order = o.id_order
        LEFT JOIN rating r 
          ON r.id_user = o.id_user 
         AND r.id_produk = od.id_produk
    """)
    rows = cursor.fetchall()

    data = defaultdict(dict)
    for r in rows:
        data[r["id_user"]][r["id_produk"]] = r["score"]

    return data

@app.route("/search")
def search():
    keyword = request.args.get("q", "")

    if keyword.strip() == "":
        return redirect(url_for("home"))

    like_keyword = f"%{keyword}%"
    cursor.execute(
        """
        SELECT * FROM data 
        WHERE nama_produk LIKE %s OR merek LIKE %s
    """,
        (like_keyword, like_keyword),
    )
    hasil = cursor.fetchall()

    # Mapping HEX
    warna_map = {
        "hitam": "#000000",
        "putih": "#FFFFFF",
        "biru metalik": "#4682B4",
        "merah": "#FF0000",
        "ungu": "#800080",
        "silver": "#C0C0C0",
        "hijau": "#32CD32",
        "abu-abu": "#808080",
    }

    for produk in hasil:
     cursor.execute("""
        SELECT vd.warna, vd.stok
        FROM varian_detail vd
        JOIN varian_produk vp ON vd.id_varian = vp.id_varian
        WHERE vp.id_produk = %s AND vd.stok > 0
    """, (produk["id_produk"],))

    varian = cursor.fetchall()

    for v in varian:
        v["warna_hex"] = warna_map.get(v["warna"].lower(), "#999999")

    produk["warna_varian"] = varian

    return render_template(
        "pencarian.html",
        keyword=keyword,
        hasil=hasil,
        cart_count=session.get("cart_count", 0),
    )


@app.route("/login_user", methods=["GET", "POST"])
def login_user():
    if request.method == "POST":
        nama = request.form["nama"]
        password = request.form["password"]

        cursor.execute(
            "SELECT * FROM users WHERE nama = %s",
            (nama,)
        )
        user = cursor.fetchone()

        if user and check_password_hash(user["password_hash"], password):
            session.clear()
            session["user_id"] = user["id_user"]
            session["role"] = user["role"]

            if user["role"] == "admin":
                return redirect(url_for("admin_dashboard"))
            else:
                return redirect(url_for("home"))

        flash("Username atau password salah!", "danger")

    return render_template("login_user.html")


@app.route("/admin/login", methods=["GET", "POST"])
def login_admin():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()

        if user and check_password_hash(user["password_hash"], password):

            if user["role"] != "admin":
                flash("Anda bukan admin!", "danger")
                return redirect(url_for("login_admin"))

            session["user_id"] = user["id_user"]
            session["role"] = "admin"

            return redirect(url_for("admin_dashboard"))

        flash("Email atau password salah!", "danger")

    return render_template("login.html")  

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        nama = request.form["nama"]
        email = request.form["email"]
        tanggal_lahir = request.form["tanggal_lahir"]
        no_hp = request.form["no_hp"]
        jenis_kelamin = request.form["jenis_kelamin"]
        region = request.form["region"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]

        # 🔥 Data alamat baru
        provinsi = request.form["provinsi"]
        kabupaten = request.form["kabupaten"]
        kecamatan = request.form["kecamatan"]
        detail_alamat = request.form["detail_alamat"]
        kode_pos = request.form["kode_pos"]

        # cek password
        if password != confirm_password:
            return render_template(
                "register.html",
                error="Password dan konfirmasi password tidak sama",
            )

        # cek email
        cursor.execute("SELECT id_user FROM users WHERE email=%s", (email,))
        if cursor.fetchone():
            return render_template(
                "register.html",
                error="Email sudah terdaftar",
            )

        pass_hash = generate_password_hash(password)

        # 1️⃣ Insert ke tabel users
        cursor.execute(
            """
            INSERT INTO users 
            (nama, email, password_hash, region, tanggal_lahir, no_hp, jenis_kelamin)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
            (nama, email, pass_hash, region, tanggal_lahir, no_hp, jenis_kelamin),
        )
        db.commit()

        id_user = cursor.lastrowid

        # 2️⃣ Insert alamat default
        cursor.execute(
            """
            INSERT INTO user_addresses
            (id_user, nama_penerima, no_hp, provinsi, kabupaten, kecamatan, detail_alamat, kode_pos, is_default)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, 1)
            """,
            (
                id_user,
                nama,              # nama penerima = nama akun
                no_hp,
                provinsi,
                kabupaten,
                kecamatan,
                detail_alamat,
                kode_pos,
            ),
        )
        db.commit()

        return redirect(url_for("login_user"))

    return render_template("register.html")
@app.route("/profil")
def profil_index():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    cursor = db.cursor(dictionary=True)

    # === DATA AKUN ===
    cursor.execute("""
        SELECT nama, email, region, foto_profil
        FROM users
        WHERE id_user = %s
    """, (session["user_id"],))
    user = cursor.fetchone()

    # === DATA PESANAN (ringkas) ===
    cursor.execute("""
        SELECT 
            o.id_order,
            o.total_harga,
            o.status_pesanan,
            o.tanggal,
            (
                SELECT d.nama_produk
                FROM order_detail od
                JOIN data d ON od.id_produk = d.id_produk
                WHERE od.id_order = o.id_order
                LIMIT 1
            ) AS nama_produk_utama,
            (
                SELECT d.gambar
                FROM order_detail od
                JOIN data d ON od.id_produk = d.id_produk
                WHERE od.id_order = o.id_order
                LIMIT 1
            ) AS gambar_utama
        FROM orders o
        WHERE o.id_user = %s
        ORDER BY o.id_order DESC
    """, (session["user_id"],))

    orders = []
    for r in cursor.fetchall():
        img = r["gambar_utama"]
        if img:
            if img.startswith("http"):
                img = img
            else:
                img = "/static/img/" + img.split("/")[-1]
        orders.append({**r, "gambar": img})

    return render_template(
        "profil/index.html",
        user=user,
        orders=orders
    )

import time
 
@app.route("/profil/akun")
def profil_akun():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT nama, email, region, foto_profil
        FROM users
        WHERE id_user = %s
    """, (session["user_id"],))

    user = cursor.fetchone()
    return render_template(
        "profil/akun.html",
        user=user,
        time=int(time.time())  
    )


@app.route("/profil/edit", methods=["POST"])
def edit_akun():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    cursor = db.cursor()

    nama = request.form["nama"]
    region = request.form["region"]
    foto = request.files.get("foto_profil")

    if foto and foto.filename:
        filename = secure_filename(foto.filename)
        ext = os.path.splitext(filename)[1]

        foto_nama = f"user_{session['user_id']}_{int(time.time())}{ext}"

        # 🔥 PATH SIMPAN FOTO
        upload_path = os.path.join(
            app.root_path, "static/profile", foto_nama
        )

        # 🔥 SIMPAN FILE
        foto.save(upload_path)

        cursor.execute("""
            UPDATE users
            SET nama=%s, region=%s, foto_profil=%s
            WHERE id_user=%s
        """, (nama, region, foto_nama, session["user_id"]))
    else:
        cursor.execute("""
            UPDATE users
            SET nama=%s, region=%s
            WHERE id_user=%s
        """, (nama, region, session["user_id"]))

    db.commit()
    return redirect(url_for("profil_index"))

@app.route("/admin/brand")
def admin_brand_list():
    cursor.execute("SELECT * FROM brand")
    data = cursor.fetchall()
    return render_template("admin/admin_brand.html", mode="list", brand=data)

@app.route("/admin/brand/add", methods=["GET", "POST"])
def admin_brand_add():
    if request.method == "POST":
        nama = request.form["nama"]
        cursor.execute("INSERT INTO brand (nama_brand) VALUES (%s)", (nama,))
        db.commit()
        return redirect(url_for("admin_brand_list"))

    return render_template("admin/admin_brand.html", mode="add")

@app.route("/admin/brand/edit/<int:id>", methods=["GET", "POST"])
def admin_brand_edit(id):
    if request.method == "POST":
        nama = request.form["nama"]
        cursor.execute("UPDATE brand SET nama_brand=%s WHERE id_brand=%s", (nama, id))
        db.commit()
        return redirect(url_for("admin_brand_list"))

    cursor.execute("SELECT * FROM brand WHERE id_brand=%s", (id,))
    brand = cursor.fetchone()
    return render_template("admin/admin_brand.html", mode="edit", brand=brand)


@app.route("/admin/brand/delete/<int:id>", methods=["POST"])
def admin_brand_delete(id):
    # Cek apakah brand ada
    cursor.execute("SELECT * FROM brand WHERE id_brand = %s", (id,))
    brand = cursor.fetchone()

    if not brand:
        flash("Brand tidak ditemukan!", "danger")
        return redirect(url_for("admin_brand_list"))

    # Hapus brand
    cursor.execute("DELETE FROM brand WHERE id_brand = %s", (id,))
    db.commit()

    flash("Brand berhasil dihapus!", "success")
    return redirect(url_for("admin_brand_list"))

@app.route("/admin/laporan")
def admin_laporan():
    return render_template("admin/laporan.html", title="Laporan Penjualan")

@app.route("/admin/konfigurasi")
def admin_konfigurasi():
    return render_template("admin/konfigurasi.html", title="Konfigurasi Sistem")


@app.route("/admin/user")
def admin_user():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    cursor = db.cursor(dictionary=True)

    # cek role admin
    cursor.execute(
        "SELECT role FROM users WHERE id_user = %s",
        (session["user_id"],)
    )
    admin = cursor.fetchone()
    if not admin or admin["role"] != "admin":
        return redirect(url_for("profil_index"))

    # ambil USER SAJA (tanpa admin)
    cursor.execute("""
        SELECT 
            id_user,
            nama,
            email,
            no_hp,
            jenis_kelamin,
            tanggal_lahir,
            created_at
        FROM users
        WHERE role = 'user'
        ORDER BY id_user ASC
    """)
    users = cursor.fetchall()

    return render_template(
        "admin/admin_user.html",
        users=users
    )


@app.route("/admin/user/edit/<int:id>", methods=["GET", "POST"])
def admin_user_edit(id):
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    cursor = db.cursor(dictionary=True)

    # cek admin
    cursor.execute(
        "SELECT role FROM users WHERE id_user=%s",
        (session["user_id"],)
    )
    admin = cursor.fetchone()
    if not admin or admin["role"] != "admin":
        return redirect(url_for("profil_index"))

    # ambil data user (hanya user, bukan admin)
    cursor.execute("""
        SELECT 
            id_user,
            nama,
            email,
            region,
            no_hp,
            jenis_kelamin,
            tanggal_lahir
        FROM users
        WHERE id_user=%s AND role='user'
    """, (id,))
    user = cursor.fetchone()

    if not user:
        flash("User tidak ditemukan!", "danger")
        return redirect(url_for("admin_user"))

    if request.method == "POST":
        nama = request.form["nama"]
        email = request.form["email"]
        region = request.form.get("region")
        no_hp = request.form.get("no_hp")
        jenis_kelamin = request.form.get("jenis_kelamin")
        tanggal_lahir = request.form.get("tanggal_lahir")

        cursor.execute("""
            UPDATE users SET
                nama=%s,
                email=%s,
                region=%s,
                no_hp=%s,
                jenis_kelamin=%s,
                tanggal_lahir=%s
            WHERE id_user=%s
        """, (
            nama,
            email,
            region,
            no_hp,
            jenis_kelamin,
            tanggal_lahir,
            id
        ))
        db.commit()

        flash("User berhasil diperbarui!", "success")
        return redirect(url_for("admin_user"))

    return render_template(
        "admin/admin_user_edit.html",
        user=user
    )


@app.route("/admin/user/delete/<int:id>", methods=["POST"])
def admin_user_delete(id):
    cursor.execute("DELETE FROM users WHERE id_user = %s", (id,))
    db.commit()

    flash("User berhasil dihapus!", "success")
    return redirect(url_for("admin_user"))


from datetime import datetime
import random

def generate_invoice():
    now = datetime.now().strftime("%Y%m%d")
    rand = random.randint(10000, 99999)
    return f"INV-{now}-{rand}"

@app.route("/admin/pesanan")
def admin_pesanan():
    cursor.execute(
        "SELECT o.*, u.nama, u.email FROM orders o JOIN users u ON o.id_user = u.id_user ORDER BY o.id_order DESC"
    )
    orders = cursor.fetchall()
    return render_template("admin/orders.html", orders=orders)

@app.route("/admin/pesanan/update/<int:id>", methods=["POST"])
def admin_order_update(id):
    status = request.form["status"]
    cursor.execute(
        "UPDATE orders SET status_pesanan = %s WHERE id_order = %s", (status, id)
    )
    db.commit()
    return redirect(url_for("admin_orders"))

@app.template_filter("rupiah")
def rupiah(x):
    try:
        return f"Rp {x:,.0f}".replace(",", ".")
    except:
        return "Rp 0"

@app.route("/profil/pesanan")
def profil_pesanan():
    if "user_id" not in session:
        return redirect(url_for("login"))

    id_user = session["user_id"]

    cursor = db.cursor(dictionary=True)

    # Ambil data pesanan + gambar + nama produk utama ===
    cursor.execute(
        """
        SELECT 
            o.*,

            -- Ambil daftar gambar
            (
                SELECT GROUP_CONCAT(d.gambar)
                FROM order_detail od
                JOIN data d ON od.id_produk = d.id_produk
                WHERE od.id_order = o.id_order
            ) AS gambar_list,

            -- Ambil nama produk utama
            (
                SELECT d.nama_produk
                FROM order_detail od
                JOIN data d ON od.id_produk = d.id_produk
                WHERE od.id_order = o.id_order
                ORDER BY od.id_order ASC
                LIMIT 1
            ) AS nama_produk_utama

        FROM orders o
        WHERE o.id_user = %s
        ORDER BY o.id_order DESC
    """,
        (id_user,),
    )

    rows = cursor.fetchall()

    orders = []

    for r in rows:

        raw_list = r.get("gambar_list") or ""
        gambar_items = [g.strip() for g in raw_list.split(",") if g.strip()]

        gambar_final = []
        for g in gambar_items:
            if g.startswith("http"):
                gambar_final.append(g)
            elif g.startswith("static/") or g.startswith("/static/"):
                gambar_final.append("/" + g.lstrip("/"))
            else:
                gambar_final.append("/static/img/" + g)

        order_obj = {
            "id_order": r["id_order"],
            "tanggal": r.get("tanggal") or r.get("created_at") or r.get("updated_at"),
            "status_pesanan": r.get("status") or r.get("status_pesanan") or "Diproses",
            "total_harga": r.get("total_harga"),
            "produk_gambar": gambar_final,
            "nama_produk_utama": r.get("nama_produk_utama"),  
        }

        orders.append(order_obj)

    for o in orders:
        print("ORDER:", o["id_order"], "NAMA:", o["nama_produk_utama"])
        print("GAMBAR:", o["produk_gambar"])

    return render_template("profil/_pesanan_list.html", orders=orders)

@app.route("/admin/laporan", methods=["GET", "POST"])
def laporan_penjualan():
    if session.get("role") != "admin":
        return redirect(url_for("login_user"))

    start = request.form.get("start_date")
    end = request.form.get("end_date")

    query = """
        SELECT 
            o.tanggal,
            u.nama AS nama_pembeli,
            p.nama_produk,
            od.jumlah,
            od.subtotal
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        JOIN order_detail od ON o.id_order = od.id_order
        JOIN data p ON od.id_produk = p.id_produk
    """

    params = ()
    if start and end:
        query += " WHERE o.tanggal BETWEEN %s AND %s"
        params = (start, end)

    query += " ORDER BY o.tanggal DESC"

    cursor.execute(query, params)
    laporan = cursor.fetchall()

    return render_template(
    "admin/laporan.html",
    laporan=laporan,
    start=start,
    end=end
)

from openpyxl import Workbook
from flask import send_file
import io

@app.route("/admin/laporan/export")
def export_laporan_excel():
    if session.get("role") != "admin":
        return redirect(url_for("login_user"))

    start = request.args.get("start")
    end = request.args.get("end")

    query = """
        SELECT 
            o.tanggal,
            u.nama AS nama_pembeli,
            p.nama_produk,
            od.jumlah,
            od.subtotal
        FROM orders o
        JOIN users u ON o.id_user = u.id_user
        JOIN order_detail od ON o.id_order = od.id_order
        JOIN data p ON od.id_produk = p.id_produk
    """

    params = ()
    if start and end:
        query += " WHERE o.tanggal BETWEEN %s AND %s"
        params = (start, end)

    query += " ORDER BY o.tanggal DESC"

    cursor.execute(query, params)
    data = cursor.fetchall()

    # Buat Excel 
    wb = Workbook()
    ws = wb.active
    ws.title = "Laporan Penjualan"

    # Header
    ws.append([
        "Tanggal",
        "Nama Pembeli",
        "Nama Produk",
        "Jumlah",
        "Subtotal"
    ])

    # Isi data
    for d in data:
        ws.append([
            d["tanggal"],
            d["nama_pembeli"],
            d["nama_produk"],
            d["jumlah"],
            d["subtotal"]
        ])

    file_stream = io.BytesIO()
    wb.save(file_stream)
    file_stream.seek(0)

    return send_file(
        file_stream,
        as_attachment=True,
        download_name="laporan_penjualan.xlsx",
        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )

@app.route("/profil/pesanan/<int:id_order>")
def pesanan_detail(id_order):

    if 'user_id' not in session:
        return redirect(url_for('login'))

    id_user = session['user_id']

    # AMBIL ORDER + LOKASI MAP 
    cursor.execute("""
        SELECT 
            id_order,
            alamat_lengkap,
            kota,
            provinsi,
            negara,
            alamat_map,
            lat,
            lng,
            metode_pembayaran,
            status_pesanan,
            ongkir,
            total_harga,
            tanggal
        FROM orders
        WHERE id_order = %s
          AND id_user = %s
    """, (id_order, id_user))

    order = cursor.fetchone()

    if not order:
        abort(404)

    #  DETAIL PRODUK 
    cursor.execute("""
        SELECT 
            od.*, 
            d.nama_produk, 
            d.harga, 
            d.gambar,
            rp.rating AS user_rating
        FROM order_detail od
        JOIN data d ON od.id_produk = d.id_produk
        LEFT JOIN rating rp 
            ON rp.id_produk = d.id_produk 
           AND rp.id_user = %s
        WHERE od.id_order = %s
    """, (id_user, id_order))

    items = cursor.fetchall()
    notif = request.args.get("status")

    for item in items:
        item["gambar_clean"] = item["gambar"].split("/")[-1]

    return render_template(
        "profil/detail_pesanan.html",
        order=order,
        items=items,
        notif=notif
    )



import qrcode
import io
import base64

def generate_qr(data: str):
    qr = qrcode.QRCode(version=1, box_size=10, border=4)
    qr.add_data(data)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white")

    buffer = io.BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)

    img_base64 = base64.b64encode(buffer.getvalue()).decode("utf-8")

    return img_base64


# --- Helper: build co-occurrence / item-users map from DB ---
def load_purchase_data(cursor):
    """
    Mengambil semua pasangan user-id -> id_produk dari order_detail JOIN orders.
    Returns: user_items: {user_id: Counter({id_produk: qty, ...}), item_users: {id_produk: set(user_id,...)}}
    """
    cursor.execute("""
        SELECT od.id_produk, od.jumlah, o.id_user
        FROM order_detail od
        JOIN orders o ON od.id_order = o.id_order
        WHERE o.id_user IS NOT NULL
    """)
    rows = cursor.fetchall()

    user_items = defaultdict(Counter)
    item_users = defaultdict(set)

    for r in rows:
        uid = r['id_user']
        pid = r['id_produk']
        qty = r.get('jumlah', 1) or 1
        user_items[uid][pid] += qty
        item_users[pid].add(uid)

    return user_items, item_users

import math
from collections import defaultdict

#Adjusted Cosine Similarity (ACS)
def compute_item_similarity_adjusted_cosine(user_items):
    """
    Hitung similarity antar item menggunakan Adjusted Cosine Similarity.
    
    user_items: dict {user_id: {item_id: rating, ...}}
    return: dict {item_i: {item_j: similarity, ...}, ...}
    """
    # 1. Hitung rata-rata rating tiap user
    user_mean = {}
    for user, items in user_items.items():
        ratings = list(items.values())
        user_mean[user] = sum(ratings) / len(ratings) if ratings else 0

    co_num = defaultdict(lambda: defaultdict(float))  
    co_den = defaultdict(lambda: defaultdict(lambda: [0.0, 0.0]))  

    for user, items in user_items.items():
        mean_u = user_mean[user]
        item_list = list(items.items())  
        for i in range(len(item_list)):
            item_i, rating_i = item_list[i]
            rating_i_adj = rating_i - mean_u
            for j in range(i+1, len(item_list)):
                item_j, rating_j = item_list[j]
                rating_j_adj = rating_j - mean_u #ru,i

                co_num[item_i][item_j] += rating_i_adj * rating_j_adj
                co_num[item_j][item_i] += rating_i_adj * rating_j_adj

                co_den[item_i][item_j][0] += rating_i_adj ** 2 #pembilang
                co_den[item_i][item_j][1] += rating_j_adj ** 2

                co_den[item_j][item_i][0] += rating_j_adj ** 2 #penyebut
                co_den[item_j][item_i][1] += rating_i_adj ** 2

    # 3. Hitung similarity
    sim = defaultdict(dict)
    for i in co_num:
        for j in co_num[i]:
            denom = math.sqrt(co_den[i][j][0]) * math.sqrt(co_den[i][j][1])
            if denom != 0:
                sim[i][j] = co_num[i][j] / denom
            else:
                sim[i][j] = 0.0  # jika denominator 0, similarity = 0

    return sim
from collections import defaultdict

def recommend_for_user(cursor, user_id, sim, user_items, N=6):
    bought = set(user_items.get(user_id, {}).keys())
    if not bought:
        return []

    scores = defaultdict(float)
    reasons = {}

    # HITUNG SKOR PREDIKSI MENGGUNAKAN ACS (rating Prediction)
    for i, rating_i in user_items[user_id].items():
        neighbors = sim.get(i, {})
        for j, sscore in neighbors.items():

            if sscore <= 0:
                continue

            if j in bought:
                continue

            scores[j] += sscore * rating_i
            if j in bought:
                continue
            scores[j] += sscore * rating_i  
            if j not in reasons or reasons[j][1] < sscore:
                reasons[j] = (i, sscore)


    if not scores:
        return []

    # Ranking kandidat (top K ranking)
    top_candidates = sorted(scores.items(), key=lambda x: x[1], reverse=True)[:N]
    if not top_candidates:
        return []

    candidate_ids = [str(cid) for cid, _ in top_candidates]
    format_strings = ",".join(["%s"] * len(candidate_ids))

    # Ambil produk dari database
    cursor.execute(f"""
        SELECT d.*
        FROM data d
        WHERE d.id_produk IN ({format_strings})
    """, tuple(candidate_ids))
    products = cursor.fetchall()

    # Gabungkan produk + similarity
    product_dict = {int(p["id_produk"]): p for p in products}
    result = []
    for cid, score in top_candidates:
        cid = int(cid)
        if cid in product_dict:
            product_data = dict(product_dict[cid])
            product_data["similarity"] = round(score, 4)
            product_data["similarity_percent"] = min(100, round(score * 100))

            reason_item = reasons.get(cid)
            if reason_item:
                product_data["reason_product"] = reason_item[0]
            product_data["similarity_percent"] = min(100, round(score * 100))
            result.append(product_data)

    return result
    

# --- Fallback: trending best-sellers ---
def trending_products(cursor, limit=6, chipset=None, layar=None, kamera=None, baterai=None):

    query = """
        SELECT d.*, SUM(od.jumlah) AS total_sold
        FROM order_detail od
        JOIN data d ON od.id_produk = d.id_produk
        WHERE 1=1
    """

    params = []

    # filter chipset
    if chipset:
        query += " AND d.chipset LIKE %s"
        params.append(f"%{chipset}%")

    # filter layar
    if layar:
        query += " AND d.layar LIKE %s"
        params.append(f"%{layar}%")

    # filter kamera
    if kamera:
        query += " AND d.kamera >= %s"
        params.append(kamera)

    # filter baterai
    if baterai:
        query += " AND d.baterai >= %s"
        params.append(baterai)

    query += """
        GROUP BY d.id_produk
        ORDER BY total_sold DESC
        LIMIT %s
    """

    params.append(limit)

    cursor.execute(query, tuple(params))
    return cursor.fetchall()

from collections import defaultdict, Counter
import math, random

def load_purchase_data(cursor):
    cursor.execute("""
        SELECT od.id_produk, od.jumlah, o.id_user
        FROM order_detail od
        JOIN orders o ON od.id_order = o.id_order
        WHERE o.id_user IS NOT NULL
    """)
    rows = cursor.fetchall()

    user_items = defaultdict(set)
    for r in rows:
        user_items[r['id_user']].add(r['id_produk'])

    return user_items

def train_test_split(user_items, test_ratio=0.2):
    train = {}
    test = {}

    for user, items in user_items.items():
        items = list(items)

        if len(items) < 2:
            # Tidak bisa split
            train[user] = set(items)
            test[user] = set()
            continue

        random.shuffle(items)
        test_size = max(1, int(len(items) * test_ratio))

        test[user] = set(items[:test_size])
        train[user] = set(items[test_size:])

    return train, test

import math
from collections import defaultdict

def compute_item_similarity(train):
    # 1️Hitung rata-rata rating tiap user
    user_mean = {}

    for user, items in train.items():
        ratings = list(items.values())
        if ratings:
            user_mean[user] = sum(ratings) / len(ratings)
        else:
            user_mean[user] = 0

    # Siapkan struktur
    numerator = defaultdict(lambda: defaultdict(float))
    denom_i = defaultdict(float)
    denom_j = defaultdict(float)

    # 3 Hitung numerator & denominator
    for user, items in train.items():
        mean_u = user_mean[user]

        item_list = list(items.items())

        for i in range(len(item_list)):
            item_i, rating_i = item_list[i]
            dev_i = rating_i - mean_u

            denom_i[item_i] += dev_i ** 2 #penyebut

            for j in range(i + 1, len(item_list)):
                item_j, rating_j = item_list[j]
                dev_j = rating_j - mean_u

                numerator[item_i][item_j] += dev_i * dev_j #pembilang
                numerator[item_j][item_i] += dev_i * dev_j

    sim = defaultdict(dict)

    for i in numerator:
        for j in numerator[i]:
            if denom_i[i] > 0 and denom_i[j] > 0:
                sim[i][j] = numerator[i][j] / (
                    math.sqrt(denom_i[i]) * math.sqrt(denom_i[j])
                )

    return sim

def recommend_eval(user, train, sim, K=5):
    bought = train.get(user, {})
    if not bought:
        return []

    scores = defaultdict(float)

    for i, rating_i in bought.items():
        for j, s in sim.get(i, {}).items():
            if j in bought:
                continue
            scores[j] += s * rating_i   # penting!

    ranked = sorted(scores.items(), key=lambda x: x[1], reverse=True)
    return [pid for pid, sc in ranked[:K]]
def precision_at_k(recommended, test_items, k=5):
    if len(test_items) == 0:
        return None

    recommended_k = recommended[:k]   # ambil top-K saja
    hits = sum(1 for item in recommended_k if item in test_items)

    return hits / k


def evaluate_ibcf(cursor, K=5):
    user_items = load_purchase_data(cursor)
    # Train-test split
    train, test = train_test_split(user_items)
    # Build similarity from TRAIN only
    sim = compute_item_similarity(train)
    # Evaluate precision
    precisions = []
    for user in user_items:

        recommended = recommend_eval(user, train, sim, K)
        p_test = test[user]

        p = precision_at_k(recommended, p_test, K)

        if p is not None:  # hanya user yang valid
            precisions.append(p)
            print(f"User {user} → Precision@{K} = {p:.3f}")
        else:
            print(f"User {user} → (skip, test set kosong)")

    if precisions:
        print("\nRATA-RATA PRECISION@{} = {:.3f}".format(K, sum(precisions)/len(precisions)))
    else:
        print("\nTidak ada user yang bisa dievaluasi.")


@app.route('/rating/<int:id_order>/<int:id_produk>', methods=['POST'])
def rating(id_order, id_produk):

    if 'user_id' not in session:
        return redirect(url_for('login'))

    id_user = session['user_id']

    # pastikan order milik user & status selesai
    cursor.execute("""
        SELECT status_pesanan
        FROM orders
        WHERE id_order=%s AND id_user=%s
    """, (id_order, id_user))

    order = cursor.fetchone()

    if not order:
        abort(403)

    if order['status_pesanan'] != 'selesai':
        flash("Rating hanya bisa diberikan setelah pesanan selesai.", "warning")
        return redirect(url_for('pesanan_detail', id_order=id_order))

    # cek apakah sudah pernah rating
    cursor.execute("""
        SELECT id FROM rating
        WHERE id_user=%s AND id_produk=%s
    """, (id_user, id_produk))

    existing = cursor.fetchone()

    if existing:
        return redirect(url_for('pesanan_detail',
                        id_order=id_order,
                        status='exists'))


    rating_value = request.form['rating']
    ulasan = request.form.get('ulasan', '')

    cursor.execute("""
        INSERT INTO rating (id_user, id_produk, rating, ulasan)
        VALUES (%s, %s, %s, %s)
    """, (id_user, id_produk, rating_value, ulasan))

    db.commit()

    return redirect(url_for('pesanan_detail',
                        id_order=id_order,
                        status='success'))


@app.template_filter("rupiah")
def rupiah(val):
    return "Rp {:,.0f}".format(val or 0).replace(",", ".")

@app.route("/wishlist/toggle/<int:id_produk>", methods=["POST"])
def toggle_wishlist(id_produk):
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    id_user = session["user_id"]

    cursor.execute("""
        SELECT * FROM wishlist 
        WHERE id_user=%s AND id_produk=%s
    """, (id_user, id_produk))

    exists = cursor.fetchone()

    if exists:
        cursor.execute("""
            DELETE FROM wishlist 
            WHERE id_user=%s AND id_produk=%s
        """, (id_user, id_produk))
    else:
        cursor.execute("""
            INSERT INTO wishlist (id_user, id_produk)
            VALUES (%s, %s)
        """, (id_user, id_produk))

    db.commit()
    return redirect(request.referrer)

@app.route("/wishlist")
def wishlist():
    if "user_id" not in session:
        return redirect(url_for("login_user"))

    id_user = session["user_id"]

    cursor.execute("""
    SELECT 
        d.*,
        MIN(v.harga) AS harga_terendah,
        AVG(r.rating) AS avg_rating,
        COUNT(r.id) AS total_rating
    FROM wishlist w
    JOIN data d ON w.id_produk = d.id_produk
    JOIN varian_produk v ON d.id_produk = v.id_produk
    LEFT JOIN rating r ON d.id_produk = r.id_produk
    WHERE w.id_user = %s
    GROUP BY d.id_produk
""", (id_user,))

    produk_wishlist = cursor.fetchall()

    return render_template(
        "wishlist.html",
        produk_wishlist=produk_wishlist
    )

def get_recommendations_for_eval(cursor, user_id, sim, user_items, N=6):
    prods = recommend_for_user(cursor, user_id, sim, user_items, N)
    return [p['id_produk'] for p in prods]


import random

def evaluate_recommendation(cursor, user_id, threshold=4):
    user_items = build_user_items(cursor)
    sim = build_item_similarity(user_items)

    user_ratings = user_items.get(user_id, {})

    if not user_ratings:
        return 0, 0, 0, [], []

    relevant_items = [
        pid for pid, r in user_ratings.items()
        if r >= threshold
    ]

    recommended_items = [
        p['id_produk']
        for p in recommend_for_user(cursor, user_id, sim, user_items)
    ]

    relevant_recommended = set(recommended_items) & set(relevant_items)

    precision = len(relevant_recommended) / len(recommended_items) if recommended_items else 0
    recall = len(relevant_recommended) / len(relevant_items) if relevant_items else 0
    accuracy = (precision + recall) / 2 * 100

    return precision, recall, accuracy, recommended_items, relevant_items


def print_evaluation(cursor, user_id, sim, user_items):
    precision, recall, accuracy, rec_items, rel_items = evaluate_recommendation(
        cursor, user_id, sim, user_items
    )

    print("=" * 50)
    print(f"Evaluasi Rekomendasi untuk User ID: {user_id}")
    print("=" * 50)
    print(f"Item Direkomendasikan : {rec_items}")
    print(f"Item Relevan          : {rel_items}")
    print("-" * 50)
    print(f"Precision             : {round(precision, 2)}")
    print(f"Recall                : {round(recall, 2)}")
    print(f"Akurasi Rekomendasi %  : {round(accuracy, 2)}")
    print("=" * 50)

def build_user_items(cursor):
    cursor.execute("""
        SELECT id_user, id_produk, rating
        FROM rating
    """)
    rows = cursor.fetchall()

    user_items = defaultdict(dict)
    for r in rows:
        user_items[r['id_user']][r['id_produk']] = r['rating']

    return user_items

def build_item_similarity(user_items):
    sim = defaultdict(dict)

    for u, items in user_items.items():
        for i in items:
            for j in items:
                if i == j:
                    continue
                sim[i][j] = sim[i].get(j, 0) + 1

    return sim

    


def get_user_ratings(user_id):
    query = """
        SELECT id_produk, rating
        FROM ratings
        WHERE id_user = %s
    """
    cursor.execute(query, (user_id,))
    rows = cursor.fetchall()

    user_ratings = {}
    for row in rows:
        user_ratings[row["id_produk"]] = row["rating"]

    return user_ratings

import math

def cosine_similarity(item1_ratings, item2_ratings):
    common_users = set(item1_ratings.keys()) & set(item2_ratings.keys())

    if not common_users:
        return 0

    numerator = sum(
        item1_ratings[u] * item2_ratings[u]
        for u in common_users
    )

    denominator = math.sqrt(
        sum(item1_ratings[u] ** 2 for u in common_users)
    ) * math.sqrt(
        sum(item2_ratings[u] ** 2 for u in common_users)
    )

    return numerator / denominator if denominator != 0 else 0

def get_all_item_ratings():
    query = "SELECT id_user, id_produk, rating FROM ratings"
    cursor.execute(query)
    rows = cursor.fetchall()

    item_ratings = {}

    for row in rows:
        item = row["id_produk"]
        user = row["id_user"]
        rating = row["rating"]

        if item not in item_ratings:
            item_ratings[item] = {}

        item_ratings[item][user] = rating

    return item_ratings

def get_recommendations(user_id, top_n=5):
    user_ratings = get_user_ratings(user_id)
    all_item_ratings = get_all_item_ratings()

    scores = {}

    for item_i in user_ratings:
        for item_j in all_item_ratings:
            if item_j in user_ratings:
                continue

            sim = cosine_similarity(
                all_item_ratings[item_i],
                all_item_ratings[item_j]
            )

            if sim <= 0:
                continue

            scores[item_j] = scores.get(item_j, 0) + sim * user_ratings[item_i]

    # === BAGIAN YANG HILANG ===
    ranked_items = sorted(
        scores.items(),
        key=lambda x: x[1],
        reverse=True
    )

    print("User Ratings:", user_ratings)
    print("All Item Ratings:", all_item_ratings)
    print("Scores:", scores)

    recommended_items = [item for item, score in ranked_items[:top_n]]
    
    return recommended_items

   #evaluasi
def fetch_ratings():
    cursor.execute("""
        SELECT id_user, id_produk, rating
        FROM rating
    """)
    rows = cursor.fetchall()

    ratings = {}
    for row in rows:
        user = row["id_user"]
        item = row["id_produk"]
        nilai = row["rating"]

        if user not in ratings:
            ratings[user] = {}
        ratings[user][item] = nilai

    return ratings

def mean_user_rating(ratings):
    mean = {}
    for user, items in ratings.items():
        mean[user] = sum(items.values()) / len(items)
    return mean

import math
from itertools import combinations

def adjusted_cosine_similarity(ratings):
    user_mean = mean_user_rating(ratings)

    items = set()
    for item_ratings in ratings.values():
        items.update(item_ratings.keys())

    similarity = {}

    for item_i, item_j in combinations(items, 2):
        numerator = 0
        denom_i = 0
        denom_j = 0

        for user, item_ratings in ratings.items():
            if item_i in item_ratings and item_j in item_ratings:
                ri = item_ratings[item_i] - user_mean[user]
                rj = item_ratings[item_j] - user_mean[user]

                numerator += ri * rj
                denom_i += ri ** 2
                denom_j += rj ** 2

        if denom_i > 0 and denom_j > 0:
            similarity[(item_i, item_j)] = round(
                numerator / (math.sqrt(denom_i) * math.sqrt(denom_j)), 2
            )

    return similarity

def print_similarity_table(similarity):
    print("\nTABEL NILAI SIMILARITY ANTAR ITEM\n")
    print("Item i\tItem j\tSimilarity")

    for (i, j), sim in similarity.items():
        print(f"{i}\t{j}\t{sim}")

@app.route("/hitung-similarity")
def hitung_similarity():
    ratings = fetch_ratings()
    similarity = adjusted_cosine_similarity(ratings)
    print_similarity_table(similarity)
    return "Perhitungan similarity selesai. Cek terminal."


import mysql.connector







if __name__ == "__main__":
    app.run(debug=True)
   
