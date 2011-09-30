;(function($){
	$.mask.masks.preco = {mask : '99,999999999999', type : 'reverse', defaultValue: '000'}
	configuraCampoData = function(alvoStr){
		$(alvoStr).datepicker(
			{
				dateFormat: 'dd/mm/yy',
				dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
				monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro']
			}
		);
		$(alvoStr).setMask('39/19/9999');
	}
	preencheCidades = function(sigla){
			$j('#instituicao_cidade').attr('disabled','disabled');
			$j('#instituicao_cidade').empty();
			$j.post('/instituicoes/retorna_cidades',{estado:sigla},
				function(data){
					$j('#instituicao_cidade').append(data['data']);
					$j('#instituicao_cidade').removeAttr('disabled');
				}
			);
	}
	preencheMarcas = function(equipamento_id){
			$j('#instituicao_cidade').attr('disabled','disabled');
			$j('#instituicao_cidade').empty();
			$j.post('/instituicoes/retorna_cidades',{estado:sigla},
				function(data){
					$j('#instituicao_cidade').append(data['data']);
					$j('#instituicao_cidade').removeAttr('disabled');
				}
			);
	}
	preencheModelos = function(sigla){
			$j('#instituicao_cidade').attr('disabled','disabled');
			$j('#instituicao_cidade').empty();
			$j.post('/instituicoes/retorna_cidades',{estado:sigla},
				function(data){
					$j('#instituicao_cidade').append(data['data']);
					$j('#instituicao_cidade').removeAttr('disabled');
				}
			);
	}
})(jQuery);
