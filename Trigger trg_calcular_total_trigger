CREATE OR REPLACE TRIGGER calcular_total_trigger
AFTER INSERT ON itens_pedido
FOR EACH ROW
DECLARE
BEGIN
  UPDATE pedidos
  SET total_pedido = calcular_total_pedido(:new.pedido_id)
  WHERE pedido_id = :new.pedido_id;
END;
