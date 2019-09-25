<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>cs425project</title>
  <link rel="stylesheet" href="https://stackedit.io/style.css" />
</head>

<body class="stackedit">
  <div class="stackedit__left">
    <div class="stackedit__toc">
      
<ul>
<li><a href="#cs425-project">CS425 Project</a>
<ul>
<li><a href="#overview">Overview</a></li>
<li><a href="#process">Process</a></li>
<li><a href="#prerequisites">Prerequisites</a></li>
<li><a href="#steps">Steps</a></li>
</ul>
</li>
</ul>

    </div>
  </div>
  <div class="stackedit__right">
    <div class="stackedit__html">
      <h1 id="cs425-project">CS425 Project</h1>
<h2 id="overview">Overview</h2>
<p>Design a database system with GUI</p>
<h2 id="process">Process</h2>
<!-- &#10;```mermaid&#10;graph BT &#10;A[Github Page: Host Website Page]-.Provide API.-&gt;B[AWS API Gateway: Host REST API]&#10;B-.Trigger Function.-&gt;C[&#34;AWS Lambda: (Java) Function Runner&#34;]&#10;C-.Fetch Data.-&gt;D[&#34;AWS RDS: Host (Postgres) Database&#34;]&#10;```&#10;-->
<p><img src="https://mermaidjs.github.io/mermaid-live-editor/#/view/eyJjb2RlIjoiZ3JhcGggQlQgXG5BW0dpdGh1YiBQYWdlOiBIb3N0IFdlYnNpdGUgUGFnZV0tLlByb3ZpZGUgQVBJLi0-QltBV1MgQVBJIEdhdGV3YXk6IEhvc3QgUkVTVCBBUEldXG5CLS5UcmlnZ2VyIEZ1bmN0aW9uLi0-Q1tcIkFXUyBMYW1iZGE6IChKYXZhKSBGdW5jdGlvbiBSdW5uZXJcIl1cbkMtLkZldGNoIERhdGEuLT5EW1wiQVdTIFJEUzogSG9zdCAoUG9zdGdyZXMpIERhdGFiYXNlXCJdXG4iLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9fQ" alt="Database Process"></p>
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

    </div>
  </div>
</body>

</html>
