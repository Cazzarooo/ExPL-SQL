DROP TABLE T_RC_AUTENTICA CASCADE CONSTRAINTS; 
DROP TABLE T_RC_CHECK_IN CASCADE CONSTRAINTS; 
DROP TABLE T_RC_CHECK_OUT CASCADE CONSTRAINTS; 
DROP TABLE T_RC_CLIENTE CASCADE CONSTRAINTS; 
DROP TABLE T_RC_ENDERECO CASCADE CONSTRAINTS; 
DROP TABLE T_RC_PAGAMENTO CASCADE CONSTRAINTS; 
DROP TABLE T_RC_PRECO_VEICULO CASCADE CONSTRAINTS; 
DROP TABLE T_RC_RESERVA CASCADE CONSTRAINTS; 
DROP TABLE T_RC_SERVICO CASCADE CONSTRAINTS; 
DROP TABLE T_RC_SERVICO_RESERVA CASCADE CONSTRAINTS; 
DROP TABLE T_RC_VEICULO CASCADE CONSTRAINTS; 

SET SERVEROUTPUT ON;

create table T_RC_CLIENTE(
id_cliente number not null
, nm_cliente  varchar2(90) not null
, nr_rg  varchar2(18)
, nr_cpf  varchar2(14) not null
, dt_nascimento date not null
, sx_cliente  varchar2(1)
, gr_ensino  varchar2(20)
, es_civil varchar2(20)
, constraint t_rc_cliente_pk primary key (id_cliente)
);

create table T_RC_PRECO_VEICULO(
id_preco number not null
,tx_dia number not null
,tx_km number not null
, constraint T_RC_PRECO_VEICULO_PK primary key (id_preco));


create table T_RC_AUTENTICA(
	id_autentica number not null
	,email varchar2(150) not null, 
	senha varchar2(30) not null,
	st_autentica varchar2(1) not null,
	t_rc_cliente_id_cliente number not null,
	constraint t_rc_autentica_pk primary key (id_autentica)
,   constraint t_rc_autentica_t_rc_cliente_fk foreign key (t_rc_cliente_id_cliente) references t_rc_cliente (id_cliente)
);


create table T_RC_VEICULO(
id_veiculo number not null
, renavam number 
, marca varchar2(50) not null
, modelo varchar2(50) not null
, placa_veiculo varchar2(10)
, tp_veiculo varchar2(10)
, cambio varchar2(10)
, t_rc_preco_veiculo_id_preco number not null
, constraint T_RC_VEICULO_PK primary key (id_veiculo)
,  constraint T_RC_VEICULO_T_RC_PRECO_VEICULO_FK foreign key (t_rc_preco_veiculo_id_preco) references T_RC_PRECO_VEICULO (id_preco)
);


create table T_RC_RESERVA(
id_reserva number not null
,t_rc_veiculo_id_veiculo number not null
,t_rc_cliente_id_cliente number not null
,dt_hr_inicio_reserva date not null
,dt_hr_fim_reserva date  not null
, constraint T_RC_RESERVA_PK primary key (id_reserva)
, constraint T_RC_RESERVA_T_RC_VEICULO_FK foreign key (t_rc_veiculo_id_veiculo) references T_RC_VEICULO (id_veiculo)
, constraint T_RC_RESERVA_T_RC_CLIENTE_FK foreign key (t_rc_cliente_id_cliente) references T_RC_CLIENTE (id_cliente));


CREATE TABLE T_RC_ENDERECO(
id_endereco number not null
,nm_logradouro varchar2(90) not null
,nr_logradouro number
,cep varchar2(10) not null
,bairro varchar2(90) not null
,cidade varchar2(90) not null
,estado varchar2(2) not null
,ds_complemento varchar2(90)
,t_rc_cliente_id_cliente  number not null
, constraint T_RC_ENDERECO_PK primary key (id_endereco)
, constraint T_RC_ENDERECO_T_RC_CLIENTE_FK foreign key (t_rc_cliente_id_cliente) references T_RC_CLIENTE (id_cliente)
);

CREATE TABLE T_RC_SERVICO(
	ID_SERVICO NUMBER NOT NULL
	,TP_SERVICO VARCHAR2(20) NOT NULL
	,TX_SERVICO NUMBER  NOT NULL
, constraint T_RC_SERVICO_PK primary key (ID_SERVICO)
);



CREATE TABLE T_RC_SERVICO_RESERVA(
T_RC_SERVICO_ID_SERVICO number not null
,T_RC_RESERVA_ID_RESERVA number not null
,ID_SERVICO_RESERVA  number not null
, constraint T_RC_SERVICO_RESERVA_PK primary key (id_servico_reserva)
, constraint T_RC_SERVICO_RESERVA_T_RC_SERVICO_FK foreign key (T_RC_SERVICO_ID_SERVICO) references T_RC_SERVICO (id_servico)
, constraint T_RC_SERVICO_RESERVA_T_RC_RESERVA_FK foreign key (T_RC_RESERVA_ID_RESERVA) references T_RC_RESERVA (id_reserva)



);



CREATE TABLE T_RC_CHECK_IN(
 ID_CHECK_IN NUMBER NOT NULL
, NV_COMBUSTIVEL NUMBER NOT NULL
, KM_ATUAL NUMBER NOT NULL
, DT_HR_CHECK_IN DATE NOT NULL
, ST_VEICULO VARCHAR2(255)NOT NULL
, T_RC_RESERVA_ID_RESERVA NUMBER NOT NULL
, constraint T_RC_CHECK_IN_PK primary key (ID_CHECK_IN)
, constraint T_RC_CHECK_IN_T_RC_RESERVA_FK foreign key (T_RC_RESERVA_ID_RESERVA) references T_RC_RESERVA (id_reserva)

);


CREATE TABLE T_RC_CHECK_OUT(
T_RC_CHECK_IN_ID_CHECK_IN NUMBER NOT NULL
,ID_CHECK_OUT NUMBER NOT NULL
,NV_COMBUSTIVEL NUMBER NOT NULL
,KM_ATUAL NUMBER 
,DT_HR_CHECK_OUT DATE NOT NULL
,ST_VEICULO VARCHAR2(255) NOT NULL
, constraint T_RC_CHECK_OUT_PK primary key (ID_CHECK_OUT)
, constraint T_RC_CHECK_OUT_T_RC_CHECK_IN_FK foreign key (T_RC_CHECK_IN_ID_CHECK_IN) references T_RC_CHECK_IN (ID_CHECK_IN)

);


create table T_RC_PAGAMENTO(
	T_CHECK_OUT_ID_CHECK_OUT NUMBER
	,ID_PAGAMENTO NUMBER
	,DT_HR_PAGAMENTO DATE
	,ST_PAGAMENTO VARCHAR2(20)
	,VL_PAGAMENTO NUMBER
	,TP_PAGAMENTO VARCHAR2(20)
	, constraint T_RC_PAGAMENTO_PK primary key (ID_PAGAMENTO)
, constraint T_RC_PAGAMENTO_T_CHECK_OUT_FK foreign key (T_CHECK_OUT_ID_CHECK_OUT) references T_RC_CHECK_OUT (ID_CHECK_OUT)

);

-- Inserir dados na tabela T_RC_PRECO_VEICULO
INSERT INTO T_RC_PRECO_VEICULO(id_preco, tx_dia, tx_km)
VALUES (1, 100, 0.50);

-- Inserir dados na tabela T_RC_VEICULO usando o id_preco inserido anteriormente
INSERT INTO T_RC_VEICULO(id_veiculo, renavam, marca, modelo, placa_veiculo, tp_veiculo, t_rc_preco_veiculo_id_preco)
VALUES (1, 123456789, 'Toyota', 'Corolla', 'ABC1234', 'Sedan', 1);

-- Inserir um cliente com todos os dados
INSERT INTO T_RC_CLIENTE (id_cliente, nm_cliente, nr_rg, nr_cpf, dt_nascimento, sx_cliente, gr_ensino, es_civil)
VALUES (1, 'João Silva', '1234567', '123.456.789-01', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'M', 'Ensino Médio', 'Solteiro');


-- Procedure para CREATE de Veículo
CREATE OR REPLACE PROCEDURE criar_veiculo(
    p_renavam IN NUMBER,
    p_marca IN VARCHAR2,
    p_modelo IN VARCHAR2,
    p_placa_veiculo IN VARCHAR2,
    p_id_preco IN NUMBER
)
IS
BEGIN
    INSERT INTO T_RC_VEICULO(renavam, marca, modelo, placa_veiculo, t_rc_preco_veiculo_id_preco)
    VALUES(p_renavam, p_marca, p_modelo, p_placa_veiculo, p_id_preco);
    COMMIT;
END criar_veiculo;
/

-- Procedure para UPDATE de Veículo
CREATE OR REPLACE PROCEDURE atualizar_veiculo(
    p_id_veiculo IN NUMBER,
    p_marca IN VARCHAR2,
    p_modelo IN VARCHAR2,
    p_placa_veiculo IN VARCHAR2
)
IS
BEGIN
    UPDATE T_RC_VEICULO
    SET marca = p_marca,
        modelo = p_modelo,
        placa_veiculo = p_placa_veiculo
    WHERE id_veiculo = p_id_veiculo;
    COMMIT;
END atualizar_veiculo;
/

-- Procedure para DELETE de Veículo
CREATE OR REPLACE PROCEDURE deletar_veiculo(
    p_id_veiculo IN NUMBER
)
IS
BEGIN
    DELETE FROM T_RC_VEICULO
    WHERE id_veiculo = p_id_veiculo;
    COMMIT;
END deletar_veiculo;
/

-- Function para READ de Veículo
CREATE OR REPLACE FUNCTION obter_veiculos RETURN SYS_REFCURSOR
IS
    veiculos_cursor SYS_REFCURSOR;
BEGIN
    OPEN veiculos_cursor FOR
    SELECT marca, modelo, placa_veiculo
    FROM T_RC_VEICULO;
    RETURN veiculos_cursor;
END obter_veiculos;
/

-- Procedimentos CRUD para as outras tabelas seguem um padrão similar

-- Cursor para Veículo com informações adicionais
DECLARE
    veiculos_cursor SYS_REFCURSOR;
    v_id_veiculo T_RC_VEICULO.id_veiculo%TYPE;
    v_renavam T_RC_VEICULO.renavam%TYPE;
    v_marca T_RC_VEICULO.marca%TYPE;
    v_modelo T_RC_VEICULO.modelo%TYPE;
    v_placa_veiculo T_RC_VEICULO.placa_veiculo%TYPE;
    v_tp_veiculo T_RC_VEICULO.tp_veiculo%TYPE;
    v_cambio T_RC_VEICULO.cambio%TYPE;
BEGIN
    veiculos_cursor := listar_veiculos_com_info;
    LOOP
        FETCH veiculos_cursor INTO v_id_veiculo, v_renavam, v_marca, v_modelo, v_placa_veiculo, v_tp_veiculo, v_cambio;
        EXIT WHEN veiculos_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_veiculo || ', Renavam: ' || v_renavam || ', Marca: ' || v_marca || ', Modelo: ' || v_modelo || ', Placa: ' || v_placa_veiculo || ', Tipo: ' || v_tp_veiculo || ', Cambio: ' || v_cambio);
    END LOOP;
    CLOSE veiculos_cursor;
END;
/

-- Cursor para Cliente
DECLARE
    clientes_cursor SYS_REFCURSOR;
    v_id_cliente T_RC_CLIENTE.id_cliente%TYPE;
    v_nm_cliente T_RC_CLIENTE.nm_cliente%TYPE;
BEGIN
    OPEN clientes_cursor FOR
        SELECT id_cliente, nm_cliente
        FROM T_RC_CLIENTE;
        
    LOOP
        FETCH clientes_cursor INTO v_id_cliente, v_nm_cliente;
        EXIT WHEN clientes_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_cliente || ', Nome: ' || v_nm_cliente);
    END LOOP;
    
    CLOSE clientes_cursor;
END;
/

