/*formato do objeto de configuracao 
   * Configuracao = {
   * 	eixo: [],
   * 	tituloGrafico: String,
   * 	tituloEixo: String,
   * 	id: String,
   * 	width: Number,
   * 	height: Number
   * }
   * 
*/
configuracao = {
	eixo: [],
	tituloGrafico: '',
	tituloEixo: 'Mês',
	id: 'contemGrafico',
	width: 600,
	height: 400
}

function graficoBarras(raw_data, configuracao) {
  //formato do raw_data [[String,numero,numero,numero],...]
  //formato do configuracao.eixo: [String,String,String], -> um elemento para cada número nos arrays do raw_data
  var data = new google.visualization.DataTable();
  eixo = configuracao.eixo
  data.addColumn('string', 'titulo');
  for (var i = 0; i  < raw_data.length; ++i) {
    data.addColumn('number', raw_data[i][0]);    
  }
  
  data.addRows(eixo.length);

  for (var j = 0; j < eixo.length; ++j) {    
    data.setValue(j, 0, eixo[j].toString());    
  }
  for (var i = 0; i  < raw_data.length; ++i) {
    for (var j = 1; j  < raw_data[i].length; ++j) {
      data.setValue(j-1, i+1, raw_data[i][j]);    
    }
  }
  
  // Create and draw the visualization.
  new google.visualization.ColumnChart(document.getElementById(configuracao.id)).
      draw(data,
           {title:configuracao.tituloGrafico, 
            height:configuracao.height,
            hAxis: {title: configuracao.tituloEixo}}
      );
}

function graficoPizza(raw_data,configuracao) {
  // formato raw_data [[String,Number],...]
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'titulo');
  data.addColumn('number', 'Quantidade');
  lim = raw_data.length
  data.addRows(lim);
  for(var i = 0; i < lim; i++){
  	data.setValue(i,0,raw_data[i][0]);
  	data.setValue(i,1,raw_data[i][1]);
  }
  
  // Create and draw the visualization.
  new google.visualization.PieChart(document.getElementById(configuracao.id)).
      draw(data, {title:configuracao.tituloGrafico, height:configuracao.height});
}

