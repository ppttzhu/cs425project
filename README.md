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
<div class="mermaid"><svg xmlns="http://www.w3.org/2000/svg" id="mermaid-svg-XsIXcFQO1ZNVIzE4" width="100%" style="max-width: 390.796875px;" viewBox="0 0 390.796875 491.65625"><g transform="translate(-12, -12)"><g class="output"><g class="clusters"></g><g class="edgePaths"><g class="edgePath" style="opacity: 1;"><path class="path" d="M207.3984375,440.5625L207.3984375,398.015625L207.3984375,355.46875" marker-end="url(#arrowhead6518)" style="fill:none"></path><defs><marker id="arrowhead6518" viewBox="0 0 10 10" refX="9" refY="5" markerUnits="strokeWidth" markerWidth="8" markerHeight="6" orient="auto"><path d="M 0 0 L 10 5 L 0 10 z" class="arrowheadPath" style="stroke-width: 1; stroke-dasharray: 1, 0;"></path></marker></defs></g><g class="edgePath" style="opacity: 1;"><path class="path" d="M207.3984375,300.375L207.3984375,257.828125L207.3984375,215.28125" marker-end="url(#arrowhead6519)" style="fill:none"></path><defs><marker id="arrowhead6519" viewBox="0 0 10 10" refX="9" refY="5" markerUnits="strokeWidth" markerWidth="8" markerHeight="6" orient="auto"><path d="M 0 0 L 10 5 L 0 10 z" class="arrowheadPath" style="stroke-width: 1; stroke-dasharray: 1, 0;"></path></marker></defs></g><g class="edgePath" style="opacity: 1;"><path class="path" d="M207.3984375,160.1875L207.3984375,117.640625L207.3984375,75.09375" marker-end="url(#arrowhead6520)" style="fill:none"></path><defs><marker id="arrowhead6520" viewBox="0 0 10 10" refX="9" refY="5" markerUnits="strokeWidth" markerWidth="8" markerHeight="6" orient="auto"><path d="M 0 0 L 10 5 L 0 10 z" class="arrowheadPath" style="stroke-width: 1; stroke-dasharray: 1, 0;"></path></marker></defs></g></g><g class="edgeLabels"><g class="edgeLabel" style="opacity: 1;" transform="translate(207.3984375,398.015625)"><g transform="translate(-55.5703125,-17.546875)" class="label"><foreignObject width="111.1429443359375" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;"><span class="edgeLabel">Provide API</span></div></foreignObject></g></g><g class="edgeLabel" style="opacity: 1;" transform="translate(207.3984375,257.828125)"><g transform="translate(-76.9453125,-17.546875)" class="label"><foreignObject width="153.9000244140625" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;"><span class="edgeLabel">Trigger Function</span></div></foreignObject></g></g><g class="edgeLabel" style="opacity: 1;" transform="translate(207.3984375,117.640625)"><g transform="translate(-51.78125,-17.546875)" class="label"><foreignObject width="103.5703125" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;"><span class="edgeLabel">Fetch Data</span></div></foreignObject></g></g></g><g class="nodes"><g class="node" style="opacity: 1;" id="A" transform="translate(207.3984375,468.109375)"><rect rx="0" ry="0" x="-163.875" y="-27.546875" width="327.75" height="55.09375"></rect><g class="label" transform="translate(0,0)"><g transform="translate(-153.875,-17.546875)"><foreignObject width="307.7578125" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;">Github Page: Host Website Page</div></foreignObject></g></g></g><g class="node" style="opacity: 1;" id="B" transform="translate(207.3984375,327.921875)"><rect rx="0" ry="0" x="-174.53125" y="-27.546875" width="349.0625" height="55.09375"></rect><g class="label" transform="translate(0,0)"><g transform="translate(-164.53125,-17.546875)"><foreignObject width="329.0625" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;">AWS API Gateway: Host REST API</div></foreignObject></g></g></g><g class="node" style="opacity: 1;" id="C" transform="translate(207.3984375,187.734375)"><rect rx="0" ry="0" x="-187.3984375" y="-27.546875" width="374.796875" height="55.09375"></rect><g class="label" transform="translate(0,0)"><g transform="translate(-177.3984375,-17.546875)"><foreignObject width="354.796875" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;">AWS Lambda: (Java) Function Runner</div></foreignObject></g></g></g><g class="node" style="opacity: 1;" id="D" transform="translate(207.3984375,47.546875)"><rect rx="0" ry="0" x="-182.2265625" y="-27.546875" width="364.453125" height="55.09375"></rect><g class="label" transform="translate(0,0)"><g transform="translate(-172.2265625,-17.546875)"><foreignObject width="344.4609375" height="35.099998474121094"><div xmlns="http://www.w3.org/1999/xhtml" style="display: inline-block; white-space: nowrap;">AWS RDS: Host (Postgres) Database</div></foreignObject></g></g></g></g></g></g></svg></div>
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
