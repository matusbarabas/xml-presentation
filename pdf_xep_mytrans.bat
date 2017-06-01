@echo off
echo XMLlint: Linking files

set SGML_CATALOG_FILES=C:\docbook\my_xsl\catalog.xml
c:\docbook\libxml\bin\xmllint.exe --catalogs --xinclude c:\Z3-xbarabas\presentation.xml > tmp.xml

echo SAXON: Generating FO

java -cp c:\docbook\resolver\;c:\docbook\resolver\resolver.jar;c:\docbook\saxon\saxon.jar;c:\docbook\xalan\bin\xercesImpl.jar;c:\docbook\xsl\extensions\saxon653.jar -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl com.icl.saxon.StyleSheet -x org.apache.xml.resolver.tools.ResolvingXMLReader -y org.apache.xml.resolver.tools.ResolvingXMLReader -r org.apache.xml.resolver.tools.CatalogResolver -o fo.xml tmp.xml mytrans.xsl

del /F tmp.xml

echo XEP: Generating PDF

call C:\docbook\xep\xep.bat -fo fo.xml -pdf presentation.pdf

del /F fo.xml

set /p delBuild=Delete preexisting build [y/n]?