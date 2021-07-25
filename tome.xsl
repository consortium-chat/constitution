<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tome="https://consortium.chat/tome"
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html xml:lang="en">
      <head>
        <title>
          <xsl:value-of select="/tome:tome/tome:title" />
        </title>
        <link
          rel="stylesheet"
          href="tome.css" />
        <script
          src="https://twemoji.maxcdn.com/v/13.1.0/twemoji.min.js"
          integrity="sha384-gPMUf7aEYa6qc3MgqTrigJqf4gzeO6v11iPCKv+AP2S4iWRWCoWyiR+Z7rWHM/hU"
          crossorigin="anonymous" />
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
    <div class="tome-tome-title">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:value-of select="../@id" />
        </xsl:attribute>
      </div>
      <a class="id-link">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="../@id" />
        </xsl:attribute>
        <xsl:value-of select="../@id" />
      </a>
      <xsl:value-of select="." />
    </div>
  </xsl:template>

  <xsl:template match="tome:chapter">
    <div class="chapter-body">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </div>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="tome:chapter/tome:title">
    <div class="tome-chapter-title">
      <a class="id-link">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
        </xsl:attribute>
        <xsl:value-of select="../@id" />
      </a>
      <span class="spacer" />
      <xsl:value-of select="." />
    </div>
  </xsl:template>

  <xsl:template match="tome:section">
    <div class="section section-with-title">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </div>
      <div class="section-title">
        <div class="section-id">
          <a class="id-link">
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:for-each select="./ancestor::*/@id">
                <xsl:value-of select="." />
              </xsl:for-each>
              <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@id" />
          </a>
        </div>
        <div class="section-title-title">
          <xsl:value-of select="tome:title" />
        </div>
      </div>
      <div class="section-content">
        <div class="section-content-spacer" />
        <div class="section-content-content">
          <xsl:apply-templates />
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tome:section/tome:title">
    <!-- nothing -->
  </xsl:template>

  <xsl:template match="tome:text">
    <div class="id-without-title">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </div>
      <div class="the-id">
        <a class="id-link">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:for-each select="./ancestor::*/@id">
              <xsl:value-of select="." />
            </xsl:for-each>
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:value-of select="@id" />
        </a>
      </div>
      <p class="id-content">
        <xsl:apply-templates />
      </p>
    </div>
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
        <xsl:choose>
          <xsl:when test="@join = 'andor'">
            <xsl:text>and/or</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="./@join" />
          </xsl:otherwise>
        </xsl:choose>
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
    <div class="marker-goto-link">
      <xsl:attribute name="id">
        <xsl:for-each select="./ancestor::*/@id">
          <xsl:value-of select="." />
        </xsl:for-each>
        <xsl:value-of select="@id" />
      </xsl:attribute>
    </div>
    <div class="id-without-title">
      <div class="the-id">
        <a class="id-link">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:for-each select="./ancestor::*/@id">
              <xsl:value-of select="." />
            </xsl:for-each>
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:value-of select="@id" />
        </a>
      </div>
      <div class="id-content">
        <xsl:apply-templates select="tome:intro" />
        <ul class="tome-list">
          <xsl:for-each select="tome:item[position() &lt; last()]">
            <li class="tome-list-item">
              <span class="tome-list-id">
                <xsl:value-of select="./@id" />
              </span>
              <xsl:apply-templates />
            </li>
          </xsl:for-each>
          <xsl:if test="tome:item[position() = 2]">
            <li class="tome-list-join">
              <xsl:choose>
                <xsl:when test="@join = 'andor'">
                  <xsl:text>and/or</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="./@join" />
                </xsl:otherwise>
              </xsl:choose>
            </li>
          </xsl:if>
          <xsl:for-each select="tome:item[position() = last()]">
            <li class="tome-list-item">
              <span class="tome-list-id">
                <xsl:value-of select="./@id" />
              </span>
              <xsl:apply-templates />
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tome:list/tome:item">
    <li class="tome-list-item">
      <span class="tome-list-id">
        <xsl:value-of select="./@id" />
      </span>
      <xsl:apply-templates />
    </li>
  </xsl:template>

  <xsl:template match="tome:list/tome:intro">
    <p class="tome-list-intro">
      <xsl:apply-templates />
    </p>
  </xsl:template>
</xsl:stylesheet>