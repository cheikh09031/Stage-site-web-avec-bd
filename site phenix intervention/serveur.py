#!/usr/bin/env python
# coding: utf-8

# PREMIER SITE ESSAI

from flask import Flask, render_template, Markup, request
import cx_Oracle
import datetime
from sqlalchemy import create_engine
from gevent.pywsgi import WSGIServer
engine = create_engine('oracle://bns2057a:BSmoi101114*@telline.univ-tlse3.fr:1521/etupre')

app=Flask(__name__)
@app.route('/')#connexion
def connexion():
    return render_template('pages/menuConnexion.html')

@app.route('/home/', methods = ['POST'])
def home(): 
    motdepasse = request.form['login_password']
    identifiant = request.form['login_login']
    strSQL = "select motdepasse from connexion where identifiant = '" + identifiant + "'" 
    print(identifiant)
    print(motdepasse)
    with engine.connect() as con:
        mdp = con.execute(strSQL)
        for row in mdp :
            for element in row : 
                if (element == motdepasse):
                    return render_template("pages/home.html", pseudo=identifiant)
    return render_template("pages/menuConnexion.html", content = -1)

@app.route('/agents/')
def agents():
    pseudo=request.args.get('pseudo')
    code_html = ""
    strSQL = "select * from info_agent"
    with engine.connect() as con:
        rs = con.execute(strSQL)
        j=0 #les lignes
        for row in rs:
            code_html += "<tr>"
            i=0#les colonnes, on donne des coordonnées à chaque bouton rejouer et à idp pour les retrouver plus facilement
            for value in row:
                code_html += "<td class='l"+str(j)+"c"+str(i)+"'>"+str(value)+"</td>"
                i+=1
            code_html += "<td class='caseinfo' l='"+str(j)+"'> <div class='btnInfos'>Plus d'infos</div> </td>"
            j+=1
    print(code_html)
    return render_template('pages/AGENTS.html', content=Markup(code_html), pseudo=pseudo)

@app.route('/clients/')
def clients():
    pseudo=request.args.get('pseudo')
    code_html = ""
    strSQL = "select * from info_Client"
    with engine.connect() as con:
        rs = con.execute(strSQL)
        j=0 #les lignes
        for row in rs:
            code_html += "<tr>"
            i=0#les colonnes, on donne des coordonnées à chaque bouton rejouer et à idp pour les retrouver plus facilement
            for value in row:
                code_html += "<td class='l"+str(j)+"c"+str(i)+"'>"+str(value)+"</td>"
                i+=1
            code_html += "<td class='caseinfo' l='"+str(j)+"'> <div class='btnInfos'>Plus d'infos</div> </td>"
            j+=1
    print(code_html)
    return render_template('pages/CLIENTS.html', content=Markup(code_html), pseudo=pseudo)

@app.route('/commandes/')
def commandes():
    pseudo=request.args.get('pseudo')
    code_html1 = ""
    code_html2 = ""
    strSQL1 = "select * from commandes_actuelles"
    strSQL2 = "select * from commandes_passees"
    with engine.connect() as con:
        rs1 = con.execute(strSQL1)
        j=0 #les lignes
        for row in rs1:
            code_html1 += "<tr>"
            i=0#les colonnes, on donne des coordonnées à chaque bouton rejouer et à idp pour les retrouver plus facilement
            for value in row:
                code_html1 += "<td class='l"+str(j)+"c"+str(i)+"'>"+str(value)+"</td>"
                i+=1
            code_html1 += "<td class='caseinfo' l='"+str(j)+"'> <div class='btnInfos'>Plus d'infos</div> </td>"
            j+=1
        rs2 = con.execute(strSQL2)
        j=0 #les lignes
        for row in rs2:
            code_html2 += "<tr>"
            i=0#les colonnes, on donne des coordonnées à chaque bouton rejouer et à idp pour les retrouver plus facilement
            for value in row:
                code_html2 += "<td class='l"+str(j)+"c"+str(i)+"'>"+str(value)+"</td>"
                i+=1
            code_html2 += "<td class='caseinfo' l='"+str(j)+"'> <div class='btnInfos'>Plus d'infos</div> </td>"
            j+=1
    return render_template('pages/COMMANDES.html', content1=Markup(code_html1), content2=Markup(code_html2), pseudo=pseudo)


if __name__=='__main__':
    app.run(debug=False)
    http_server = WSGIServer(('', 5000), app)
    http_server.serve_forever()
















# In[ ]:




