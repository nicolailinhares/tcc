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
			$('#instituicao_cidade').attr('disabled','disabled');
			$('#instituicao_cidade').empty();
			$.post('/instituicoes/retorna_cidades',{estado:sigla},
				function(data){
					$('#instituicao_cidade').append(data['data']);
					$('#instituicao_cidade').removeAttr('disabled');
				}
			);
	}
	preencheModelos = function(equipamento,marca){
			$('#modelo_id').attr('disabled','disabled');
			$('#modelo_id').empty();
			$.post('/ajax/busca_modelos',{equipamento_id:equipamento, marca_id: marca},
				function(data){
					if(!data['erro']){
						$('#modelo_id').append(data['data']);
						$('#modelo_id').removeAttr('disabled');
					}
				}
			);
	}
	selecionaMenu = function(id){
		$j('#menuLateral').children().each(function(){
			$j(this).removeClass('selecionado');
		});
		$j('#menuLateral #'+id).addClass('selecionado');
	}
})(jQuery);
