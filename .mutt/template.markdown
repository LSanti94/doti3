<html>
$if(titleblock)$
$titleblock$

$endif$
$for(header-includes)$
$header-includes$

$endfor$
$for(include-before)$
$include-before$

$endfor$
$if(toc)$
$table-of-contents$

$endif$
<body style="background-color:#E6E6FA;color:black">
<font size="+10">
$body$
</font>
</body>
$for(include-after)$

$include-after$
$endfor$
</html>
