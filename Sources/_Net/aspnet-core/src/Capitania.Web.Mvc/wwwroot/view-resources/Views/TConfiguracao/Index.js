(function () {
	$(function () {

		var _configService = abp.services.app.tConfiguracao;
		var _$modal = $('#ConfigCreateModal');
		var _$form = _$modal.find('form');

		_$form.validate({
		});

		$('#RefreshButton').click(function () {
			refreshConfigList();
		});

		$('.edit-config').click(function (e) {
			var configId = $(this).attr("data-config-id");

			e.preventDefault();
			$.ajax({
                url: abp.appPath + 'TConfiguracao/TConfiguracaoDetalhesModal?codigo=' + configId,
				type: 'POST',
				contentType: 'application/html',
				success: function (content) {
					$('#ConfigEditModal div.modal-content').html(content);
				},
				error: function (e) { }
			});
		});

		_$form.find('button[type="submit"]').click(function (e) {
			e.preventDefault();

			if (!_$form.valid()) {
				return;
			}

			var config = _$form.serializeFormToObject(); //serializeFormToObject is defined in main.js
            
			abp.ui.setBusy(_$modal);
			_configService.createOrEdit(config).done(function () {
				_$modal.modal('hide');
				location.reload(true); //reload page to see new config!
			}).always(function () {
				abp.ui.clearBusy(_$modal);
			});
		});

		_$modal.on('shown.bs.modal', function () {
			_$modal.find('input:not([type=hidden]):first').focus();
		});

		function refreshConfigList() {
			location.reload(true); //reload page to see new config!
		}
	});
})();