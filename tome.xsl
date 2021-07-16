<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tome="https://consortium.chat/tome"
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output

    />
  <xsl:template match="/">
    <html xml:lang="en">
      <head>
        <title><xsl:value-of select="/tome:tome/tome:title" /></title>
        <link rel="stylesheet" href="tome.css" />
      </head>
      <body>
        <div class="container">
          <xsl:apply-templates />
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="/tome:tome/tome:title">
    <h1><xsl:value-of select="."/></h1>
  </xsl:template>
  <xsl:template match="tome:chapter">
    <div class="chapter">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <xsl:template match="tome:chapter">
    <div class="chapter-body">
      <xsl:apply-templates  select="./*[not(tome:title)]"/>
    </div>
  </xsl:template>
  <xsl:template match="tome:chapter/tome:title">
    <h2>
      <xsl:value-of select="../@id" /> <xsl:value-of select="." />
    </h2>
  </xsl:template>
  <xsl:template match="tome:section/tome:title">
    <h3><xsl:value-of select="." /></h3>
  </xsl:template>
  <xsl:template match="tome:section">
    <div class="section">
      <xsl:value-of select="./@id" /> 
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <xsl:template match="tome:text">
    <p><xsl:apply-templates /></p>
  </xsl:template>
</xsl:stylesheet>