---


---

<h1 id="cs425-project">CS425 Project</h1>
<h2 id="overview">Overview</h2>
<p>Design a database system with GUI</p>
<h2 id="process">Process</h2>
<!-- &#10;```mermaid&#10;graph BT &#10;A[Github Page: Host Website Page]-.Provide API.-&gt;B[AWS API Gateway: Host REST API]&#10;B-.Trigger Function.-&gt;C[&#34;AWS Lambda: (Java) Function Runner&#34;]&#10;C-.Fetch Data.-&gt;D[&#34;AWS RDS: Host (Postgres) Database&#34;]&#10;```&#10;-->
<p><img src="https://github.com/ppttzhu/cs425project/blob/master/db%20process.jpg" alt="Image of DatabaseProcess"></p>
<h2 id="prerequisites">Prerequisites</h2>
<ul>
<li>Terminal</li>
<li>Postgresql: Connect to AWS RDS</li>
<li>Java</li>
<li>Eclipse: Java editor (Optional)</li>
<li>npm</li>
<li>Vue</li>
<li>Visual Studio Code: Vue editor (Optional)</li>
</ul>
<h2 id="steps">Steps</h2>
<ol>
<li>Run below script in terminal to connect to AWS RDS:<br>
<code>psql --host=cs425project.ck5idh9xvvie.us-east-1.rds.amazonaws.com --port=5432 --username=ppttzhu --password --dbname=cs425project</code></li>
<li>Write Java code to fetch data from AWS RDS (<strong>TO BE ADDED</strong>)</li>
<li>Upload Java code to AWS Lambda (Visible with permission)</li>
<li>Add Lambda in AWS API Gateway as a resourse (Visible with permission)</li>
<li>Use Vue.axios to write GET/PUT method in API
<ul>
<li>Download code in current repo</li>
<li><code>npm install</code></li>
<li><code>npm run serve</code></li>
<li><code>npm run build</code></li>
<li>See <a href="https://cli.vuejs.org/config/">Configuration Reference</a> for detail</li>
</ul>
</li>
<li>Sync code to github and create github page to host it</li>
</ol>

