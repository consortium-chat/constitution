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
          rel="preconnect"
          href="https://fonts.googleapis.com" />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin="" />
        <link
          href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&amp;display=swap"
          rel="stylesheet" />
        <link
          rel="stylesheet"
          href="tome.css" />
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1" />
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

  <xsl:template match="/tome:tome">
    <div class="tome-tome-title">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </div>
      <a class="id-link">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:value-of select="@id" />
      </a>
      <xsl:value-of select="tome:title" />
    </div>
    <div id="toc" style="margin-left: 20px">
      <input type="checkbox" id="show-toc" />
      <label class="bold-3 toc-main-title" for="show-toc" tabindex="0">
        <span class="chevron" />
        Table of Contents
      </label>
      <ul class="toc-list" id="main-toc-list">
        <xsl:apply-templates mode="toc" />
      </ul>
      <hr />
    </div>
    <div class="main-content">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="tome:title" mode="toc"><!-- nothing --></xsl:template>

  <xsl:template match="tome:chapter|tome:section" mode="toc">
    <li>
      <a class="toc-list-id">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:value-of select="@id" />
      </a>
      <div class="toc-list-content">
        <div class="bold-2">
          <xsl:value-of select="tome:title" />
        </div>
        <ul class="toc-list">
          <xsl:apply-templates mode="toc" />
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="tome:text|tome:list" mode="toc">
    <li class="toc-list-inline">
      <a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:value-of select="@id" />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="/tome:tome/tome:title">
  </xsl:template>

  <xsl:template match="tome:chapter">
    <div class="chapter-body">
      <div class="marker-goto-link-chapter">
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
          <xsl:apply-templates select="tome:item[position() &lt; last()]" />
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
          <xsl:apply-templates select="tome:item[position() = last()]" />
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tome:list/tome:item">
    <li class="tome-list-item">
      <div class="marker-goto-link">
        <xsl:attribute name="id">
          <xsl:for-each select="./ancestor::*/@id">
            <xsl:value-of select="." />
          </xsl:for-each>
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </div>
      <div class="tome-list-item-wrapper">
        <div class="tome-list-id">
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
        <div class="tome-list-item-content">
          <xsl:apply-templates />
        </div>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="tome:list/tome:intro">
    <p class="tome-list-intro">
      <xsl:apply-templates />
    </p>
  </xsl:template>
</xsl:stylesheet>