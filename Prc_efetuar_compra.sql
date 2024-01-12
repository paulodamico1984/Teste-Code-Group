CREATE OR REPLACE PROCEDURE realizar_compra(
    p_cliente_id IN NUMBER,
    p_produto_id IN NUMBER,
    p_quantidade IN NUMBER
) IS
  v_pedido_id NUMBER;
BEGIN
  -- Inicia a transação
  SAVEPOINT inicio_transacao;

  -- Insere o pedido
  INSERT INTO pedidos (pedido_id, cliente_id, data_pedido, total_pedido)
  VALUES (seq_pedidos.NEXTVAL, p_cliente_id, SYSDATE, 0)
  RETURNING pedido_id INTO v_pedido_id;

  -- Inserir o item no pedido
  INSERT INTO itens_pedido (item_id, pedido_id, produto_id, quantidade)
  VALUES (seq_itens_pedido.NEXTVAL, v_pedido_id, p_produto_id, p_quantidade);

  -- Atualiza o total do pedido
  UPDATE pedidos
  SET total_pedido = calcular_total_pedido(v_pedido_id)
  WHERE pedido_id = v_pedido_id;

  -- Confirmar a transação
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    -- Rollback em caso de erro
    ROLLBACK TO inicio_transacao;
    DBMS_OUTPUT.PUT_LINE('Erro ao realizar compra: ' || SQLERRM);
END realizar_compra;
