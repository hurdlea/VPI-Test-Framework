# Vpi_2_5.rb

# ============================================================================ #
# Format template for FPE schema version 2.5                                   #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Initial Version                                     #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

# This is an ERB template
class Vpi2_5
  
  def Vpi2_5.get_xml_template
%{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<FeatureExport xmlns="http://foxtel.tv/engineering/bcms/schemas/exchange/2/5" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" activate="<%= @item['offer']['activate'] %>" origin="IBMS" packageId="<%= @item['offer']['id'] %>" publishedDate="<%= @item['date'] %>" schemaVersion="2.5.0">
  <Header>
    <ExhibitionWindow end="<%= @item['offer']['window']['end'] %>" offerType="<%= @item['offer']['offerType'] %>" price="<%= @item['offer']['price'] %>" start="<%= @item['offer']['window']['start'] %>"/>
    <Terms>
      <Term type="<%= @item['offer']['accessTerm'] %>">
      <Parameter name="profile"/>
      <Parameter name="policy"/>
      <Parameter name="download">true</Parameter>
      <Parameter name="streaming">false</Parameter>
<% if @item['offer'].has_key?('rental') -%>
      <Parameter name="rentalHours"><%= @item['offer']['rental'] %></Parameter>
<% end -%>
      <Parameter name="retentionPeriod"><%= @item['offer']['retention'] %></Parameter>
<% if @item['offer'].has_key?('timeToStartView') -%>
      <Parameter name="rentalHours"><%= @item['offer']['timeToStartView'] %></Parameter>
<% end -%>
    </Term>
    <Term type="PR1">
      <Parameter name="product"><%= @item['offer']['type'] %></Parameter>
    </Term>
    </Terms>
    <Destinations accessTerm="<%= @item['offer']['accessTerm'] %>" destinationID="nagra" productTerm="PR1">
      <Destination accessTerm="<%= @item['offer']['accessTerm'] %>" destinationID="nagra" deviceId="STBmanaged" productTerm="PR1"/>
    </Destinations>
  </Header>
  <Feature>
    <Description bugging="false" category="<%= @item['content']['category'] %>" groupID="" library="true" programmeId="<%= @item['content']['programme'] %>" providerId="<%= @item['offer']['provider'] %>" showID="<%= @item['content']['show'] %>" versionCopyId="<%= @item['programme']['versionCopy'] %>" versionId="<%= @item['programme']['version'] %>">
      <Title><%= @item['content']['title'] %></Title>
      <ShortSynopsis><%= @item['content']['description'] %></ShortSynopsis>
      <LongSynopsis><%= @item['content']['description'] %></LongSynopsis>
<% if @item['offer']['marketing'] -%>
      <MarketingMessage><%= @item['offer']['marketing'] %></MarketingMessage>
<% end -%>
      <VideoFormat><%= @item['offer']['resolution'] %></VideoFormat>
      <NominalDuration><%= @item['content']['duration'] %></NominalDuration>
      <Genre main="<%= @item['content']['genre']['main'] %>" sub="<%= @item['content']['genre']['sub'] %>"><%= GENRES[@item['content']['genre']['main']][@item['content']['genre']['sub']] %></Genre>
      <ParentalRating><%= @item['offer']['rating'] %></ParentalRating>
<% if @item['offer'].has_key?('warnings') -%>
      <ConsumerWarnings><%= @item['offer']['warnings'].split(',').join(' ') %></ConsumerWarnings>
<% end -%>
      <Subtitled>false</Subtitled>
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
  </Feature>
  <Media>
    <Videos>
      <Video class="feature">
        <Duration><%= @item['programme']['duration'] %></Duration>
        <AspectRatio>16x9</AspectRatio>
        <ClosedCaptions>false</ClosedCaptions>
        <Sound><%= @item['offer']['sound'] %></Sound>
        <Files base="">
           <File assetId="<%= @item['programme']['asset'] %>" bitrate="8000" contentType="video/mp2ts" fileSize="1064772592" filename="<%= @item['offer']['asset'] %>.ts" height="576" width="720"/>
        </Files>
      </Video>
    </Videos>
    <Images>
      <ImageSource base="">
        <Image class="poster" contentType="image/jpeg" fileSize="138265" filename="<%= @item['image'] %>.jpg" imageId="I@<%= @item['image'] %>"/>
        <Image class="landscape" contentType="image/jpeg" fileSize="144832" filename="<%= @item['image'] %>_L.jpg" imageId="<%= @item['image'] %>_L"/>
      </ImageSource>
    </Images>
  </Media>
</FeatureExport>
}
  end
  
end