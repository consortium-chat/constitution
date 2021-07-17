<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tome="https://consortium.chat/tome"
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html xml:lang="en">
      <head>
        <title><xsl:value-of select="/tome:tome/tome:title" /></title>
        <link rel="stylesheet" href="tome.css" />
        <script src="https://twemoji.maxcdn.com/v/13.1.0/twemoji.min.js" integrity="sha384-gPMUf7aEYa6qc3MgqTrigJqf4gzeO6v11iPCKv+AP2S4iWRWCoWyiR+Z7rWHM/hU" crossorigin="anonymous"></script>
      </head>
      <body>
        <div class="container">
          <xsl:apply-templates />
        </div>
        <script>twemoji.parse(document.body)</script>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="/tome:tome/tome:title">
    <div class="tome-tome-title"><xsl:value-of select="." /></div>
  </xsl:template>
  <xsl:template match="tome:chapter">
    <div class="chapter">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <xsl:template match="tome:chapter">
    <div class="chapter-body">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <xsl:template match="tome:chapter/tome:title">
    <div class="tome-chapter-title">
      <xsl:value-of select="../@id" />
      <span class="spacer"></span>
      <xsl:value-of select="." />
    </div>
  </xsl:template>
  <xsl:template match="tome:section[tome:title]">
    <div class="section section-with-title">
      <div class="section-title">
        <div class="section-id"><xsl:value-of select="./@id" /></div>
        <div class="section-title-title"><xsl:value-of select="tome:title" /></div>
      </div>
      <div class="section-content">
        <div class="section-content-spacer"></div>
        <div class="section-content-content">
          <xsl:apply-templates />
        </div>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="tome:section[not(tome:title)]">
    <div class="section section-without-title">
      <div class="section-id"><xsl:value-of select="./@id" /></div>
      <div class="section-content-content">
        <xsl:apply-templates />
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="tome:section/tome:title"><!-- nothing --></xsl:template>
  <xsl:template match="tome:text">
    <p><xsl:apply-templates /></p>
  </xsl:template>
  <xsl:template match="tome:inlist">
    <span class="tome-inlist">
      <xsl:for-each select="tome:item[position() &lt; last()]">
        <span class="tome-inlist-item">
          <xsl:apply-templates />
        </span>
        <xsl:text>, </xsl:text>
      </xsl:for-each>
      <xsl:if test="tome:item[position() = 2]">
        <xsl:value-of select="./@join" />
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:for-each select="tome:item[position() = last()]">
        <span class="tome-inlist-item">
          <xsl:apply-templates />
        </span>
      </xsl:for-each>
    </span>
  </xsl:template>
  <xsl:template match="tome:list">
    <ul class="tome-list">
      <xsl:for-each select="tome:item[position() &lt; last()]">
        <li class="tome-list-item">
          <span class="tome-list-id"><xsl:value-of select="./@id" /></span>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
      <xsl:if test="tome:item[position() = 2]">
        <li class="tome-list-join"><xsl:value-of select="./@join" /></li>
      </xsl:if>
      <xsl:for-each select="tome:item[position() = last()]">
        <li class="tome-list-item">
          <span class="tome-list-id"><xsl:value-of select="./@id" /></span>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>