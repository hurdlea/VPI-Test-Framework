# Vpi_3_0.rb

# ============================================================================ #
# Format template for FPE schema version 2.5                                   #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Initial Version                                     #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

# This is an ERB template
class Vpi3_0
  
  def Vpi3_0.get_xml_template
%{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<FeatureExport xmlns="http://foxtel.tv/engineering/vpi/schemas/exchange/3/0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" signature="<%= @item['signature'] %>" origin="IBMS" publishedDate="<%= @item['date'] %>" schemaVersion="3.0.0">
  <Offer id="<%= @item['offer']['id'] %>" activate="<%= @item['offer']['activate'] %>" operation="<%= @offer_operation %>">
    <ExhibitionWindow start="<%= @item['offer']['window']['start'] %>" end="<%= @item['offer']['window']['end'] %>" price="<%= @item['offer']['price'] %>" offerType="<%= @item['offer']['offerType'] %>"/>
    <ProviderId><%= @item['offer']['provider'] %></ProviderId>
    <Distributor reportingCode="<%= @item['offer']['provider'] %>" name="<%= @item['offer']['provider'] %>"/>
    <Deal purchaseId="" groupId=""/>
    <ParentalRating><%= @item['offer']['rating'] %></ParentalRating>
<% if @item['offer'].has_key?('warnings') -%>
    <ConsumerWarnings>
<% index = 1 -%>
<% for flag in @item['offer']['warnings'].split(',') -%>
      <Warning order="<%= index %>" severity="<%= WARNINGS[@item['offer']['rating']][1] %>" label="<%= WARNINGS[@item['offer']['rating']][0] %><%= WARNINGS['base'][flag] %>" code="<%= flag %>"/>
<% index += 1 -%>
<% end -%>
    </ConsumerWarnings>
<% end -%>
    <VideoFormat><%= @item['offer']['resolution'] %></VideoFormat>
    <Sound><%= @item['offer']['sound'] %></Sound>
    <Subtitled>false</Subtitled>
    <ContentGrouping>
      <ContentGroup name="main title">
        <VideoRef id="<%= @item['programme']['asset'] %>" class="feature"/>
<% if @item.has_key?('trailer') -%>
        <VideoRef id="<%= @item['trailer']['asset'] %>" class="trailer"/>
<% end -%>
        <ImageRef id="<%= @item['image'] %>_L" format="JPG" class="landscape"/>
        <ImageRef id="<%= @item['image'] %>" format="JPG" class="poster"/>
      </ContentGroup>
    </ContentGrouping>
    <Terms>
      <Term type="<%= @item['offer']['accessTerm'] %>">
        <Parameter name="streaming">true</Parameter>
        <Parameter name="download">true</Parameter>
<% if @item['offer'].has_key?('rental') -%>
        <Parameter name="rentalHours"><%= @item['offer']['rental'] %></Parameter>
<% end -%>
        <Parameter name="retentionPeriod"><%= @item['offer']['retention'] %></Parameter>
<% if @item['offer'].has_key?('timeToStartView') -%>
        <Parameter name="rentalHours"><%= @item['offer']['timeToStartView'] %></Parameter>
<% end -%>
      </Term>
      <Term type="PR01">
        <Parameter name="product"><%= @item['offer']['type'] %></Parameter>
      </Term>
        <Destinations accessTerm="<%= @item['offer']['accessTerm'] %>" destinationID="nagra" productTerm="PR1">
          <Destination accessTerm="<%= @item['offer']['accessTerm'] %>" destinationID="nagra" deviceId="STBmanaged" productTerm="PR1"/>
        </Destinations>
      </Terms>
  </Offer>
  <Feature id="">
    <Description category="<%= @item['content']['category'] %>" library="true" programmeId="<%= @item['content']['programme'] %>" titleId="<%= @item['content']['show'] %>">
      <Title><%= @item['content']['title'] %></Title>
      <ShortSynopsis><%= @item['content']['description'] %></ShortSynopsis>
      <LongSynopsis><%= @item['content']['description'] %></LongSynopsis>
      <NominalDuration><%= @item['content']['duration'] %></NominalDuration>
      <Genre main="<%= @item['content']['genre']['main'] %>" sub="<%= @item['content']['genre']['sub'] %>"><%= GENRES[@item['content']['genre']['main']][@item['content']['genre']['sub']] %></Genre>
<% if @item['content'].has_key?('production') -%>
      <Production>
        <Year><%= @item['content']['production']['year'] %></Year>
        <Colour><%= @item['content']['production']['colour'] %></Colour>
        <Country><%= @item['content']['production']['country'] %></Country>
      </Production>
<% end -%>
<% if @item['content'].has_key?('episode') -%>
      <SeasonNumber><%= @item['content']['episode']['season'] %></SeasonNumber>
      <EpisodeNumber><%= @item['content']['episode']['episode_number'] %></EpisodeNumber>
      <EpisodeTitle><%= @item['content']['episode']['title'] %></EpisodeTitle>
<% end -%>
    </Description>
    <Images>
      <ImageSource>
        <Image class="poster" contentType="image/jpeg" fileSize="1294603" filename="<%= @item['image'] %>.jpg" imageId="<%= @item['image'] %>.jpg"/>
        <Image class="landscape" contentType="image/jpeg" fileSize="2110563" filename="I@<%= @item['image'] %>_L.jpg" imageId="<%= @item['image'] %>_L.jpg"/>
      </ImageSource>
    </Images>
  </Feature>
  <Media>
    <Videos>
      <Video class="feature" assetId="<%= @item['programme']['asset'] %>" versionId="<%= @item['programme']['version'] %>" versionCopyId="<%= @item['programme']['versionCopy'] %>" operation="<%= @media_operation %>">
        <LicenseWindow start="<%= @item['programme']['license']['start'] %>" end="<%= @item['programme']['license']['end'] %>"/>
        <MediaDescription><%= @item['content']['title'] %></MediaDescription>
        <ParentalRating><%= @item['offer']['rating'] %></ParentalRating>
<% if @item['offer'].has_key?('warnings') -%>
        <ConsumerWarnings>
<% index = 1 -%>
<% for flag in @item['offer']['warnings'].split(',') -%>
          <Warning order="<%= index %>" severity="<%= WARNINGS[@item['offer']['rating']][1] %>" label="<%= WARNINGS[@item['offer']['rating']][0] %><%= WARNINGS['base'][flag] %>" code="<%= flag %>"/>
<% index += 1 -%>
<% end -%>
        </ConsumerWarnings>
<% end -%>
        <Duration><%= @item['programme']['duration'] %></Duration>
        <AspectRatio>16x9</AspectRatio>
        <ClosedCaptions>false</ClosedCaptions>
        <Playback>
          <AccessControl>
            <Parameter name="contentId">FXTL_<%= @item['programme']['asset'] %></Parameter>
          </AccessControl>
        </Playback>
        <Files>
          <File assetId="<%= @item['programme']['asset'] %>_SD_PDL" bitrate="1800000" contentType="video/mp2ts" fileSize="1944090140" filename="<%= @item['programme']['asset'] %>-576p25.ts" height="576" width="720" resolution="SD" sound="Stereo"/>
<% if @item['offer']['resolution'] == 'HD' -%>
          <File assetId="<%= @item['programme']['asset'] %>_HD_PDL" bitrate="4500000" contentType="video/mp2ts" fileSize="3888090140" filename="<%= @item['programme']['asset'] %>-720p50.ts" height="720" width="1280" resolution="HD" sound="Digital"/>
<% end -%>
          <Location assetId="<%= @item['programme']['asset'] %>_SD_ABR" contentType="smooth" nominalSize="1944090140" uri="http://origin.foxtel.com.au/location/<%= @item['programme']['asset'] %>/<%= @item['programme']['asset'] %>_hss.ism/manifest_sd" variant="medium" resolution="SD" sound="Stereo"/>
<% if @item['offer']['resolution'] == 'HD' -%>
          <Location assetId="<%= @item['programme']['asset'] %>_HD_ABR" contentType="smooth" nominalSize="3888090140" uri="http://origin.foxtel.com.au/location/<%= @item['programme']['asset'] %>/<%= @item['programme']['asset'] %>_hss.ism/manifest_hd" variant="high" resolution="HD" sound="Digital"/>
<% end -%>
        </Files>
      </Video>
<% if @item.has_key?('trailer') -%>
      <Video class="trailer" assetId="<%= @item['trailer']['asset'] %>" operation="<%= @trailer_operation %>">
        <LicenseWindow start="<%= @item['trailer']['license']['start'] %>" end="<%= @item['trailer']['license']['end'] %>"/>
        <Duration><%= @item['trailer']['duration'] %></Duration>
        <AspectRatio>16x9</AspectRatio>
        <Files>
          <File assetId="<%= @item['trailer']['asset'] %>_HD_PDL" bitrate="3000000" contentType="video/mp2ts" fileSize="1944090140" filename="<%= @item['trailer']['asset'] %>-576p25.ts" height="720" width="1280" resolution="HD" sound="Stereo"/>
          <Location assetId="<%= @item['trailer']['asset'] %>_HD_ABR" contentType="smooth" nominalSize="3888090140" uri="http://origin.foxtel.com.au/location/<%= @item['programme']['asset'] %>/<%= @item['programme']['asset'] %>_hss.ism/manifest_hd" variant="high" resolution="HD" sound="Digital"/>
        </Files>
      </Video>
<% end -%>
    </Videos>
  </Media>
</FeatureExport>
}
  end
  
end