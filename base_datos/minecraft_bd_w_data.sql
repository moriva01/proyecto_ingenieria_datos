PGDMP  #    6            	    |            minecraft_bd    16.4    16.4 R               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16803    minecraft_bd    DATABASE     �   CREATE DATABASE minecraft_bd WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE minecraft_bd;
                postgres    false                       0    0    DATABASE minecraft_bd    ACL     1   GRANT ALL ON DATABASE minecraft_bd TO connector;
                   postgres    false    4883                       0    0    SCHEMA public    ACL     ,   GRANT CREATE ON SCHEMA public TO connector;
                   pg_database_owner    false    5            �            1255    16923    actualizar_creditos_wallet()    FUNCTION     �  CREATE FUNCTION public.actualizar_creditos_wallet() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualiza la cantidad de créditos en la Wallet del jugador
    UPDATE Wallet
    SET Creditos = Creditos + (SELECT Cantidad_Creditos FROM Paquete_Creditos WHERE ID_Paquete = NEW.ID_Paquete)
    WHERE ID_Wallet = (SELECT ID_Wallet FROM Jugador WHERE ID_Jugador = NEW.ID_Jugador);
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.actualizar_creditos_wallet();
       public       	   connector    false            �            1259    16864    apuesta    TABLE     �   CREATE TABLE public.apuesta (
    id_apuesta integer NOT NULL,
    id_jugador integer,
    id_objeto integer,
    cantidad integer NOT NULL,
    resultado character varying(20)
);
    DROP TABLE public.apuesta;
       public         heap 	   connector    false            �            1259    16863    apuesta_id_apuesta_seq    SEQUENCE     �   CREATE SEQUENCE public.apuesta_id_apuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.apuesta_id_apuesta_seq;
       public       	   connector    false    226                       0    0    apuesta_id_apuesta_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.apuesta_id_apuesta_seq OWNED BY public.apuesta.id_apuesta;
          public       	   connector    false    225            �            1259    16906    compra    TABLE     �   CREATE TABLE public.compra (
    id_compra integer NOT NULL,
    id_jugador integer,
    id_paquete integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.compra;
       public         heap 	   connector    false            �            1259    16905    compra_id_compra_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.compra_id_compra_seq;
       public       	   connector    false    232                       0    0    compra_id_compra_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.compra_id_compra_seq OWNED BY public.compra.id_compra;
          public       	   connector    false    231            �            1259    16881 
   inventario    TABLE     �   CREATE TABLE public.inventario (
    id_inventario integer NOT NULL,
    id_jugador integer,
    id_objeto integer,
    cantidad integer NOT NULL
);
    DROP TABLE public.inventario;
       public         heap 	   connector    false            �            1259    16880    inventario_id_inventario_seq    SEQUENCE     �   CREATE SEQUENCE public.inventario_id_inventario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.inventario_id_inventario_seq;
       public       	   connector    false    228                       0    0    inventario_id_inventario_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.inventario_id_inventario_seq OWNED BY public.inventario.id_inventario;
          public       	   connector    false    227            �            1259    16814    jugador    TABLE     �   CREATE TABLE public.jugador (
    id_jugador integer NOT NULL,
    nickname character varying(30) NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    id_wallet integer
);
    DROP TABLE public.jugador;
       public         heap 	   connector    false            �            1259    16813    jugador_id_jugador_seq    SEQUENCE     �   CREATE SEQUENCE public.jugador_id_jugador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.jugador_id_jugador_seq;
       public       	   connector    false    218                       0    0    jugador_id_jugador_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.jugador_id_jugador_seq OWNED BY public.jugador.id_jugador;
          public       	   connector    false    217            �            1259    16835    objeto    TABLE     �   CREATE TABLE public.objeto (
    id_objeto integer NOT NULL,
    nombre_objeto character varying(50),
    cantidad_max integer NOT NULL,
    valor integer NOT NULL
);
    DROP TABLE public.objeto;
       public         heap 	   connector    false            �            1259    16834    objeto_id_objeto_seq    SEQUENCE     �   CREATE SEQUENCE public.objeto_id_objeto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.objeto_id_objeto_seq;
       public       	   connector    false    222                       0    0    objeto_id_objeto_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.objeto_id_objeto_seq OWNED BY public.objeto.id_objeto;
          public       	   connector    false    221            �            1259    16898    paquete_creditos    TABLE     �   CREATE TABLE public.paquete_creditos (
    id_paquete integer NOT NULL,
    nombre character varying(50) NOT NULL,
    cantidad_creditos integer NOT NULL,
    precio_usd numeric(5,2) NOT NULL,
    bonificacion integer DEFAULT 0
);
 $   DROP TABLE public.paquete_creditos;
       public         heap 	   connector    false            �            1259    16897    paquete_creditos_id_paquete_seq    SEQUENCE     �   CREATE SEQUENCE public.paquete_creditos_id_paquete_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.paquete_creditos_id_paquete_seq;
       public       	   connector    false    230                       0    0    paquete_creditos_id_paquete_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.paquete_creditos_id_paquete_seq OWNED BY public.paquete_creditos.id_paquete;
          public       	   connector    false    229            �            1259    16828    tipo_transaccion    TABLE     �   CREATE TABLE public.tipo_transaccion (
    id_tipo_transaccion integer NOT NULL,
    nombre_tipo character varying(50) NOT NULL
);
 $   DROP TABLE public.tipo_transaccion;
       public         heap 	   connector    false            �            1259    16827 (   tipo_transaccion_id_tipo_transaccion_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_transaccion_id_tipo_transaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.tipo_transaccion_id_tipo_transaccion_seq;
       public       	   connector    false    220                       0    0 (   tipo_transaccion_id_tipo_transaccion_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.tipo_transaccion_id_tipo_transaccion_seq OWNED BY public.tipo_transaccion.id_tipo_transaccion;
          public       	   connector    false    219            �            1259    16842    transaccion    TABLE     �   CREATE TABLE public.transaccion (
    id_transaccion integer NOT NULL,
    origen integer,
    destino integer,
    descripcion character varying(80) NOT NULL,
    id_tipo_transaccion integer
);
    DROP TABLE public.transaccion;
       public         heap 	   connector    false            �            1259    16841    transaccion_id_transaccion_seq    SEQUENCE     �   CREATE SEQUENCE public.transaccion_id_transaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.transaccion_id_transaccion_seq;
       public       	   connector    false    224                       0    0    transaccion_id_transaccion_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.transaccion_id_transaccion_seq OWNED BY public.transaccion.id_transaccion;
          public       	   connector    false    223            �            1259    16807    wallet    TABLE     ^   CREATE TABLE public.wallet (
    id_wallet integer NOT NULL,
    creditos integer NOT NULL
);
    DROP TABLE public.wallet;
       public         heap 	   connector    false            �            1259    16806    wallet_id_wallet_seq    SEQUENCE     �   CREATE SEQUENCE public.wallet_id_wallet_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.wallet_id_wallet_seq;
       public       	   connector    false    216                       0    0    wallet_id_wallet_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.wallet_id_wallet_seq OWNED BY public.wallet.id_wallet;
          public       	   connector    false    215            H           2604    16867    apuesta id_apuesta    DEFAULT     x   ALTER TABLE ONLY public.apuesta ALTER COLUMN id_apuesta SET DEFAULT nextval('public.apuesta_id_apuesta_seq'::regclass);
 A   ALTER TABLE public.apuesta ALTER COLUMN id_apuesta DROP DEFAULT;
       public       	   connector    false    226    225    226            L           2604    16909    compra id_compra    DEFAULT     t   ALTER TABLE ONLY public.compra ALTER COLUMN id_compra SET DEFAULT nextval('public.compra_id_compra_seq'::regclass);
 ?   ALTER TABLE public.compra ALTER COLUMN id_compra DROP DEFAULT;
       public       	   connector    false    232    231    232            I           2604    16884    inventario id_inventario    DEFAULT     �   ALTER TABLE ONLY public.inventario ALTER COLUMN id_inventario SET DEFAULT nextval('public.inventario_id_inventario_seq'::regclass);
 G   ALTER TABLE public.inventario ALTER COLUMN id_inventario DROP DEFAULT;
       public       	   connector    false    227    228    228            D           2604    16817    jugador id_jugador    DEFAULT     x   ALTER TABLE ONLY public.jugador ALTER COLUMN id_jugador SET DEFAULT nextval('public.jugador_id_jugador_seq'::regclass);
 A   ALTER TABLE public.jugador ALTER COLUMN id_jugador DROP DEFAULT;
       public       	   connector    false    217    218    218            F           2604    16838    objeto id_objeto    DEFAULT     t   ALTER TABLE ONLY public.objeto ALTER COLUMN id_objeto SET DEFAULT nextval('public.objeto_id_objeto_seq'::regclass);
 ?   ALTER TABLE public.objeto ALTER COLUMN id_objeto DROP DEFAULT;
       public       	   connector    false    222    221    222            J           2604    16901    paquete_creditos id_paquete    DEFAULT     �   ALTER TABLE ONLY public.paquete_creditos ALTER COLUMN id_paquete SET DEFAULT nextval('public.paquete_creditos_id_paquete_seq'::regclass);
 J   ALTER TABLE public.paquete_creditos ALTER COLUMN id_paquete DROP DEFAULT;
       public       	   connector    false    229    230    230            E           2604    16831 $   tipo_transaccion id_tipo_transaccion    DEFAULT     �   ALTER TABLE ONLY public.tipo_transaccion ALTER COLUMN id_tipo_transaccion SET DEFAULT nextval('public.tipo_transaccion_id_tipo_transaccion_seq'::regclass);
 S   ALTER TABLE public.tipo_transaccion ALTER COLUMN id_tipo_transaccion DROP DEFAULT;
       public       	   connector    false    219    220    220            G           2604    16845    transaccion id_transaccion    DEFAULT     �   ALTER TABLE ONLY public.transaccion ALTER COLUMN id_transaccion SET DEFAULT nextval('public.transaccion_id_transaccion_seq'::regclass);
 I   ALTER TABLE public.transaccion ALTER COLUMN id_transaccion DROP DEFAULT;
       public       	   connector    false    223    224    224            C           2604    16810    wallet id_wallet    DEFAULT     t   ALTER TABLE ONLY public.wallet ALTER COLUMN id_wallet SET DEFAULT nextval('public.wallet_id_wallet_seq'::regclass);
 ?   ALTER TABLE public.wallet ALTER COLUMN id_wallet DROP DEFAULT;
       public       	   connector    false    215    216    216                      0    16864    apuesta 
   TABLE DATA           Y   COPY public.apuesta (id_apuesta, id_jugador, id_objeto, cantidad, resultado) FROM stdin;
    public       	   connector    false    226   /c                 0    16906    compra 
   TABLE DATA           J   COPY public.compra (id_compra, id_jugador, id_paquete, fecha) FROM stdin;
    public       	   connector    false    232   c       	          0    16881 
   inventario 
   TABLE DATA           T   COPY public.inventario (id_inventario, id_jugador, id_objeto, cantidad) FROM stdin;
    public       	   connector    false    228   �c       �          0    16814    jugador 
   TABLE DATA           Q   COPY public.jugador (id_jugador, nickname, "contraseña", id_wallet) FROM stdin;
    public       	   connector    false    218   d                 0    16835    objeto 
   TABLE DATA           O   COPY public.objeto (id_objeto, nombre_objeto, cantidad_max, valor) FROM stdin;
    public       	   connector    false    222   �d                 0    16898    paquete_creditos 
   TABLE DATA           k   COPY public.paquete_creditos (id_paquete, nombre, cantidad_creditos, precio_usd, bonificacion) FROM stdin;
    public       	   connector    false    230   f                 0    16828    tipo_transaccion 
   TABLE DATA           L   COPY public.tipo_transaccion (id_tipo_transaccion, nombre_tipo) FROM stdin;
    public       	   connector    false    220   �f                 0    16842    transaccion 
   TABLE DATA           h   COPY public.transaccion (id_transaccion, origen, destino, descripcion, id_tipo_transaccion) FROM stdin;
    public       	   connector    false    224   g       �          0    16807    wallet 
   TABLE DATA           5   COPY public.wallet (id_wallet, creditos) FROM stdin;
    public       	   connector    false    216   �g                  0    0    apuesta_id_apuesta_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.apuesta_id_apuesta_seq', 5, true);
          public       	   connector    false    225                        0    0    compra_id_compra_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.compra_id_compra_seq', 5, true);
          public       	   connector    false    231            !           0    0    inventario_id_inventario_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.inventario_id_inventario_seq', 5, true);
          public       	   connector    false    227            "           0    0    jugador_id_jugador_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.jugador_id_jugador_seq', 5, true);
          public       	   connector    false    217            #           0    0    objeto_id_objeto_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.objeto_id_objeto_seq', 20, true);
          public       	   connector    false    221            $           0    0    paquete_creditos_id_paquete_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.paquete_creditos_id_paquete_seq', 5, true);
          public       	   connector    false    229            %           0    0 (   tipo_transaccion_id_tipo_transaccion_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.tipo_transaccion_id_tipo_transaccion_seq', 5, true);
          public       	   connector    false    219            &           0    0    transaccion_id_transaccion_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.transaccion_id_transaccion_seq', 5, true);
          public       	   connector    false    223            '           0    0    wallet_id_wallet_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.wallet_id_wallet_seq', 5, true);
          public       	   connector    false    215            [           2606    16869    apuesta apuesta_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.apuesta
    ADD CONSTRAINT apuesta_pkey PRIMARY KEY (id_apuesta);
 >   ALTER TABLE ONLY public.apuesta DROP CONSTRAINT apuesta_pkey;
       public         	   connector    false    226            a           2606    16912    compra compra_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id_compra);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public         	   connector    false    232            ]           2606    16886    inventario inventario_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);
 D   ALTER TABLE ONLY public.inventario DROP CONSTRAINT inventario_pkey;
       public         	   connector    false    228            Q           2606    16821    jugador jugador_nickname_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.jugador
    ADD CONSTRAINT jugador_nickname_key UNIQUE (nickname);
 F   ALTER TABLE ONLY public.jugador DROP CONSTRAINT jugador_nickname_key;
       public         	   connector    false    218            S           2606    16819    jugador jugador_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.jugador
    ADD CONSTRAINT jugador_pkey PRIMARY KEY (id_jugador);
 >   ALTER TABLE ONLY public.jugador DROP CONSTRAINT jugador_pkey;
       public         	   connector    false    218            W           2606    16840    objeto objeto_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.objeto
    ADD CONSTRAINT objeto_pkey PRIMARY KEY (id_objeto);
 <   ALTER TABLE ONLY public.objeto DROP CONSTRAINT objeto_pkey;
       public         	   connector    false    222            _           2606    16904 &   paquete_creditos paquete_creditos_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.paquete_creditos
    ADD CONSTRAINT paquete_creditos_pkey PRIMARY KEY (id_paquete);
 P   ALTER TABLE ONLY public.paquete_creditos DROP CONSTRAINT paquete_creditos_pkey;
       public         	   connector    false    230            U           2606    16833 &   tipo_transaccion tipo_transaccion_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.tipo_transaccion
    ADD CONSTRAINT tipo_transaccion_pkey PRIMARY KEY (id_tipo_transaccion);
 P   ALTER TABLE ONLY public.tipo_transaccion DROP CONSTRAINT tipo_transaccion_pkey;
       public         	   connector    false    220            Y           2606    16847    transaccion transaccion_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_pkey PRIMARY KEY (id_transaccion);
 F   ALTER TABLE ONLY public.transaccion DROP CONSTRAINT transaccion_pkey;
       public         	   connector    false    224            O           2606    16812    wallet wallet_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id_wallet);
 <   ALTER TABLE ONLY public.wallet DROP CONSTRAINT wallet_pkey;
       public         	   connector    false    216            l           2620    16924     compra trigger_actualizar_wallet    TRIGGER     �   CREATE TRIGGER trigger_actualizar_wallet AFTER INSERT ON public.compra FOR EACH ROW EXECUTE FUNCTION public.actualizar_creditos_wallet();
 9   DROP TRIGGER trigger_actualizar_wallet ON public.compra;
       public       	   connector    false    232    233            f           2606    16870    apuesta apuesta_id_jugador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.apuesta
    ADD CONSTRAINT apuesta_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES public.jugador(id_jugador);
 I   ALTER TABLE ONLY public.apuesta DROP CONSTRAINT apuesta_id_jugador_fkey;
       public       	   connector    false    218    226    4691            g           2606    16875    apuesta apuesta_id_objeto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.apuesta
    ADD CONSTRAINT apuesta_id_objeto_fkey FOREIGN KEY (id_objeto) REFERENCES public.objeto(id_objeto);
 H   ALTER TABLE ONLY public.apuesta DROP CONSTRAINT apuesta_id_objeto_fkey;
       public       	   connector    false    222    226    4695            j           2606    16913    compra compra_id_jugador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES public.jugador(id_jugador);
 G   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_id_jugador_fkey;
       public       	   connector    false    232    218    4691            k           2606    16918    compra compra_id_paquete_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_id_paquete_fkey FOREIGN KEY (id_paquete) REFERENCES public.paquete_creditos(id_paquete);
 G   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_id_paquete_fkey;
       public       	   connector    false    232    230    4703            h           2606    16887 %   inventario inventario_id_jugador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES public.jugador(id_jugador);
 O   ALTER TABLE ONLY public.inventario DROP CONSTRAINT inventario_id_jugador_fkey;
       public       	   connector    false    228    218    4691            i           2606    16892 $   inventario inventario_id_objeto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_objeto_fkey FOREIGN KEY (id_objeto) REFERENCES public.objeto(id_objeto);
 N   ALTER TABLE ONLY public.inventario DROP CONSTRAINT inventario_id_objeto_fkey;
       public       	   connector    false    4695    228    222            b           2606    16822    jugador jugador_id_wallet_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jugador
    ADD CONSTRAINT jugador_id_wallet_fkey FOREIGN KEY (id_wallet) REFERENCES public.wallet(id_wallet);
 H   ALTER TABLE ONLY public.jugador DROP CONSTRAINT jugador_id_wallet_fkey;
       public       	   connector    false    216    218    4687            c           2606    16853 $   transaccion transaccion_destino_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_destino_fkey FOREIGN KEY (destino) REFERENCES public.jugador(id_jugador);
 N   ALTER TABLE ONLY public.transaccion DROP CONSTRAINT transaccion_destino_fkey;
       public       	   connector    false    4691    218    224            d           2606    16858 0   transaccion transaccion_id_tipo_transaccion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_id_tipo_transaccion_fkey FOREIGN KEY (id_tipo_transaccion) REFERENCES public.tipo_transaccion(id_tipo_transaccion);
 Z   ALTER TABLE ONLY public.transaccion DROP CONSTRAINT transaccion_id_tipo_transaccion_fkey;
       public       	   connector    false    4693    220    224            e           2606    16848 #   transaccion transaccion_origen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_origen_fkey FOREIGN KEY (origen) REFERENCES public.jugador(id_jugador);
 M   ALTER TABLE ONLY public.transaccion DROP CONSTRAINT transaccion_origen_fkey;
       public       	   connector    false    4691    218    224               @   x�3�4BSN�ļĔ�".#N#NNC΀Ԣ�T��1'�U� 區z�
L9A�� F��� z�V         F   x�}��� ���
 �g����:B
��;���M;��'��+c{ʍ�GT n�
L�z�y�      	   -   x���  ��m1�C���J�5�G�J��l��~S�5w���      �   �   x�˻JD1 �z�12�G2)ul���&�L@\�J\��WO2<_�;21T��K�"���9m�5.9CN���y��us�ŵ�E����,��Pb����/}�c�/C�霕z]*R":�R8	ܝ��؀Tk�Ⓡ�1)��_mF�l I�#>b?|]��dT-X�2_��UrBw���@��MJ���A�         (  x�UPKN�@]{N��8M�vKUVU�%7c�H��⤛^�#p1�FA��xo���1�^�@����aS���`�gF�X$�Tj1��_+^�.y���$��]�\��X(z2	����3�+%*|�c�e�܆��d˕��k��g}lT���4:Z��m�����Nb	o�3.�.�@1x�w%"<EnO�x�Y���q���[�+�~�imaP{�b�ρ��m5�K�J��р���v>�AӦi�ڟ%Z�X��Z{��3���^�ո(nf|�e��o�RU	��!w�{p��ݐ�         |   x�3�H,,M-IUp:��839������D�ҒӀ�.�W�Z������ihT`	R`d�eW�X��W����i2������ �(57�4��$o�76�2���, Y2ހ�,oj�����  �,<         \   x�3�t��-(JTHIU�O�J-��2�K�+A1�)J�+NK-J�K��8^��Y�_�e��XP�Z��������e
H-J����qqq [i"�         �   x�u�A
�@�u�9��N=���F\�q���u�f�E��k���LE�.�@V�燎JXg�(-v�>����et:��2#���J"������X6$�`
������|�I���`��
�0������Y"!���d�|d�os&�ˢ�
�r��+�4��uǪZ�I�����vQ�����܎�1/]f�      �   )   x�3�4220�2�44RƜ�@ʄ�Hs�r�x1z\\\ {��     