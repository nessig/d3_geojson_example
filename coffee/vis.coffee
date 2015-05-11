
$ ->
  console.log('ready')

  width = 900
  height = 900

  ###y2rcs = ['rgb(255,255,178)',
                'rgb(254,204,92)',
                'rgb(253,141,60)',
                'rgb(240,59,32)',
                'rgb(189,0,38)']###
  y2rcs = ['#ffffb2'
            '#fecc5c'
            '#fd8d3c'
            '#f03b20'
            '#bd0026']
  projection = d3.geo.albersUsa().scale(1).translate([0,0])
  path = d3.geo.path().projection(projection)

  vis = d3.select("#vis")
    .append("svg")
    .attr("width", width)
    .attr("height", height)

  d3.json "data/USDM_20150505.json", (json) ->
    console.log('loaded geojson')
    # code to automatically figure out projection scale and translation
    # from: http://bl.ocks.org/mbostock/4707858
    # (d.properties['DM'] for d in data.features)
    bounds = path.bounds(json)
    s = .95 / Math.max((bounds[1][0] - bounds[0][0]) / width, (bounds[1][1] - bounds[0][1]) / height)
    t = [(width - s * (bounds[1][0] + bounds[0][0])) / 2, (height - s * (bounds[1][1] + bounds[0][1])) / 2]

    projection
      .scale(s)
      .translate(t)
    ###y2rcs = ['#ffffb2'
            '#fecc5c'
            '#fd8d3c'
            '#f03b20'
            '#bd0026']###
    vis.append("g")
      .attr("class", "tracts")
    .selectAll("path")
      .data(json.features)
    .enter().append("path")
      .attr("d", path)
      .attr("fill-opacity", 0.5)
      #.attr("fill", (d) -> if d.properties["STATEFP10"] == "20" then "#B5D9B9" else "#85C3C0")
      .attr("fill", (d) -> y2rcs[d.properties["DM"]])
      #.attr("fill", (d) -> rgb(240,59,32))
      #console.log y2scs[d.properties["DM"]]
      .attr("stroke", "#222")

###
  {
    "type": "FeatureCollection",
    "features": [
        {
          "type": "Feature",
          "properties": {

              "OBJECTID": 1,
              "DM": 0, 
              "Shape_Leng": 57228199.673, 
              "Shape_Area": 1771707975650 

              },
          "geometry": { 
              "type": "MultiPolygon",
              "coordinates": [ 
              [ [ [ -65.732587879786735, 18.153899155605885 ], [ -65.733511036882376, 18.153424226471447 ], [ -65.734434194###