# MERCADOLIBRE

Challenge Mercadolibre

1.Pantalla de ingreso de monto.

2.Selección de medio de pago (de tipo credit_card). Los medios de pago puede ser: Visa, Mastercard, American Express, etc. Mostrar nombre e imagen. Para acceder a estos medios de pago, se consulta a la siguiente URL: https://api.mercadopago.com/v1/payment_methods?public_key=PUBLIC_KEY (Método GET).

3.Selección de banco. Los bancos pueden ser: ICBC, Santander, Galicia, entre otros. Mostrar nombre e imagen. Estos operan con diversos medios de pago de pago, por lo que debes consumir una API para poder saber cuáles son los bancos disponibles para el medio de pago seleccionado. https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=PUBLIC_KEY&payment_method_id=MEDIO_DE_PAGO_SELECCIONADO (Método GET).

4.Selección de cuotas. Luego de tener el medio de pago y las el banco seleccionados, el usuario debe seleccionar la cantidad de cuotas en las que desea pagar el monto ingresado en el paso 1. La API provee un recommended_message que resuelve el mensaje que se debe mostrar al usuario con la cantidad de cuotas, el valor de cada cuota y el monto final. Mostrar el recommended_message. https://api.mercadopago.com/v1/payment_methods/installments?public_key=PUBLIC_KEY&amount=MONTO_DEL_PASO_1&payment_method_id=MEDIO_DE_PAGO_SELECCIONADO&issuer.id=ISSUER_SELECCIONADO (Método GET).

-------------------------------------------------------------------------------------
Developed by Federico Frias 2016
Contact Info:

fedefrias@gmail.com
ffrias@bminds.com.ar
@fedefrias
