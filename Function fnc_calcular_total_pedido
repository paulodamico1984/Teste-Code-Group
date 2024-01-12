CREATE OR REPLACE FUNCTION calcular_total_pedido(p_pedido_id IN NUMBER) RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT SUM(ip.quantidade * pr.preco)
  INTO v_total
  FROM itens_pedido ip
  JOIN produtos pr ON ip.produto_id = pr.produto_id
  WHERE ip.pedido_id = p_pedido_id;

  RETURN NVL(v_total, 0);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END calcular_total_pedido;
/
