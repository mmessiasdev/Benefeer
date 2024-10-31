'use strict';

const QRCode = require('qrcode');

module.exports = {
    async generateQRCode(ctx) {
        const storeId = ctx.params.id;  // Supondo que você tenha o ID da loja

        if (!storeId) {
            return ctx.badRequest('ID da loja é necessário');
        }

        // Suponha que você esteja gerando um QR Code para uma URL com base no ID da loja
        const url = `https://09af-2804-548-10fd-aa00-f569-ae9f-2f06-1c60.ngrok-free.app/local-stores/${storeId}`;

        try {
            const qrCodeData = await QRCode.toDataURL(url);

            // Você pode retornar o QR Code como base64 para ser renderizado em uma tag <img>
            ctx.send({ qrCode: qrCodeData });
        } catch (error) {
            ctx.badRequest('Erro ao gerar QR Code', { error });
        }
    },
};
