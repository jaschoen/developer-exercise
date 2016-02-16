$(function() {
  // Initialize collection
  var quotes = new QuotesCollection();
  // Setup Columns 
  var columns = [
    {
      name: "source",
      label: "Source",
      cell: "string",
      editable: false
    }, {
      name: "context",
      label: "Context",
      cell: "string",
      editable: false
    }, {
      name: "quote",
      label: "Quote",
      cell: "string",
      editable: false
    }, {
      name: "theme",
      label: "Theme",
      cell: "string",
      editable: false
    }
    ];
  // Initialize grid
  var grid = new Backgrid.Grid({
        columns: columns,
        collection: quotes
      });
  // Render Grid
  $("#grid").append(grid.render().el);

  // Initialize Paginator
  var paginator = new Backgrid.Extension.Paginator({
    collection: quotes
  });
  // Render Paginator
  $("#paginator").append(paginator.render().el);

  // Get Data
  quotes.fetch({reset: true});

})