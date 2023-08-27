PGDMP                         {            iot_company_project001    15.2    15.2 2    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            K           1262    24576    iot_company_project001    DATABASE     �   CREATE DATABASE iot_company_project001 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
 &   DROP DATABASE iot_company_project001;
                postgres    false                        3079    24577 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            L           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    24587    change_reason    TABLE     �   CREATE TABLE public.change_reason (
    sno integer,
    reason character varying(150) NOT NULL,
    time_ time without time zone
);
 !   DROP TABLE public.change_reason;
       public         heap    postgres    false            �            1259    24598    employee_master    TABLE     �  CREATE TABLE public.employee_master (
    employee_code character varying(40) NOT NULL,
    employee_name character varying(40) NOT NULL,
    employee_designation character varying(40) NOT NULL,
    area_of_work character varying(40) NOT NULL,
    employee_address character varying(40) NOT NULL,
    employee_aadhaar character varying(40) NOT NULL,
    employee_mobile_no character varying(40) NOT NULL,
    function_manager character varying(40) NOT NULL,
    em_efficiency integer
);
 #   DROP TABLE public.employee_master;
       public         heap    postgres    false            �            1259    32769    logincredentials    TABLE     �   CREATE TABLE public.logincredentials (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL
);
 $   DROP TABLE public.logincredentials;
       public         heap    postgres    false            �            1259    32768    logincredentials_id_seq    SEQUENCE     �   CREATE SEQUENCE public.logincredentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.logincredentials_id_seq;
       public          postgres    false    225            M           0    0    logincredentials_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.logincredentials_id_seq OWNED BY public.logincredentials.id;
          public          postgres    false    224            �            1259    40981    machine_data    TABLE     �   CREATE TABLE public.machine_data (
    machine_no character varying(255) NOT NULL,
    current_count character varying(255) NOT NULL,
    efficiency integer NOT NULL,
    efficiency_count character varying(255) NOT NULL
);
     DROP TABLE public.machine_data;
       public         heap    postgres    false            �            1259    24601    machine_master    TABLE     Z  CREATE TABLE public.machine_master (
    mno character varying(40) NOT NULL,
    mname character varying(40) NOT NULL,
    mcat character varying(40) NOT NULL,
    mmnu character varying(40) NOT NULL,
    contdet character varying(40) NOT NULL,
    doc character varying(40),
    mkva character varying(40) NOT NULL,
    mm_efficiency integer
);
 "   DROP TABLE public.machine_master;
       public         heap    postgres    false            �            1259    24604    machine_operator    TABLE     �  CREATE TABLE public.machine_operator (
    sno integer NOT NULL,
    product_line character varying(40) NOT NULL,
    date_ date NOT NULL,
    shift character varying(40) NOT NULL,
    machine_no character varying(40) NOT NULL,
    operator_id character varying(40) NOT NULL,
    part_no character varying(40) NOT NULL,
    shift_supervisor_name character varying(40) NOT NULL,
    time_ time without time zone DEFAULT now() NOT NULL,
    operator_change character varying(10) DEFAULT 'N'::character varying NOT NULL,
    old_alloc integer DEFAULT 0,
    mo_efficiency integer,
    mo_count integer,
    shift_supervisor_id character varying(40),
    tool_no character varying(40)
);
 $   DROP TABLE public.machine_operator;
       public         heap    postgres    false            �            1259    24607    machine_operator_sno_seq    SEQUENCE     �   CREATE SEQUENCE public.machine_operator_sno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.machine_operator_sno_seq;
       public          postgres    false    218            N           0    0    machine_operator_sno_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.machine_operator_sno_seq OWNED BY public.machine_operator.sno;
          public          postgres    false    219            �            1259    24611    part_master    TABLE     K  CREATE TABLE public.part_master (
    pcode character varying(40) NOT NULL,
    pdes character varying(40) NOT NULL,
    cpn character varying(40) NOT NULL,
    proline character varying(40) NOT NULL,
    npccps character varying(40) NOT NULL,
    pdesc character varying(40) NOT NULL,
    efficiency_tolarance integer NOT NULL
);
    DROP TABLE public.part_master;
       public         heap    postgres    false            �            1259    24614    product_line_master    TABLE     �   CREATE TABLE public.product_line_master (
    pcode character varying(40) NOT NULL,
    pline character varying(40) NOT NULL
);
 '   DROP TABLE public.product_line_master;
       public         heap    postgres    false            �            1259    24617    shift_master    TABLE        CREATE TABLE public.shift_master (
    scode character varying(40) NOT NULL,
    sname character varying(40) NOT NULL,
    brlu character varying(40) NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL
);
     DROP TABLE public.shift_master;
       public         heap    postgres    false            �            1259    49153 	   tool_data    TABLE     �   CREATE TABLE public.tool_data (
    id integer NOT NULL,
    tool_no character varying(255) NOT NULL,
    machine_no character varying(100) NOT NULL,
    reason character varying(255) NOT NULL
);
    DROP TABLE public.tool_data;
       public         heap    postgres    false            �            1259    49152    tool_data_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tool_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.tool_data_id_seq;
       public          postgres    false    228            O           0    0    tool_data_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.tool_data_id_seq OWNED BY public.tool_data.id;
          public          postgres    false    227            �            1259    24624    tool_master    TABLE     �   CREATE TABLE public.tool_master (
    tno character varying(40) NOT NULL,
    tname character varying(40) NOT NULL,
    ttype character varying(40) NOT NULL,
    tlpc character varying(40) NOT NULL,
    maccat character varying(40) NOT NULL
);
    DROP TABLE public.tool_master;
       public         heap    postgres    false            �           2604    32772    logincredentials id    DEFAULT     z   ALTER TABLE ONLY public.logincredentials ALTER COLUMN id SET DEFAULT nextval('public.logincredentials_id_seq'::regclass);
 B   ALTER TABLE public.logincredentials ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    24627    machine_operator sno    DEFAULT     |   ALTER TABLE ONLY public.machine_operator ALTER COLUMN sno SET DEFAULT nextval('public.machine_operator_sno_seq'::regclass);
 C   ALTER TABLE public.machine_operator ALTER COLUMN sno DROP DEFAULT;
       public          postgres    false    219    218            �           2604    49156    tool_data id    DEFAULT     l   ALTER TABLE ONLY public.tool_data ALTER COLUMN id SET DEFAULT nextval('public.tool_data_id_seq'::regclass);
 ;   ALTER TABLE public.tool_data ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            8          0    24587    change_reason 
   TABLE DATA           ;   COPY public.change_reason (sno, reason, time_) FROM stdin;
    public          postgres    false    215   j>       9          0    24598    employee_master 
   TABLE DATA           �   COPY public.employee_master (employee_code, employee_name, employee_designation, area_of_work, employee_address, employee_aadhaar, employee_mobile_no, function_manager, em_efficiency) FROM stdin;
    public          postgres    false    216   ?       B          0    32769    logincredentials 
   TABLE DATA           H   COPY public.logincredentials (id, username, password, role) FROM stdin;
    public          postgres    false    225   �C       C          0    40981    machine_data 
   TABLE DATA           _   COPY public.machine_data (machine_no, current_count, efficiency, efficiency_count) FROM stdin;
    public          postgres    false    226   E       :          0    24601    machine_master 
   TABLE DATA           c   COPY public.machine_master (mno, mname, mcat, mmnu, contdet, doc, mkva, mm_efficiency) FROM stdin;
    public          postgres    false    217   =E       ;          0    24604    machine_operator 
   TABLE DATA           �   COPY public.machine_operator (sno, product_line, date_, shift, machine_no, operator_id, part_no, shift_supervisor_name, time_, operator_change, old_alloc, mo_efficiency, mo_count, shift_supervisor_id, tool_no) FROM stdin;
    public          postgres    false    218   %F       =          0    24611    part_master 
   TABLE DATA           e   COPY public.part_master (pcode, pdes, cpn, proline, npccps, pdesc, efficiency_tolarance) FROM stdin;
    public          postgres    false    220   �I       >          0    24614    product_line_master 
   TABLE DATA           ;   COPY public.product_line_master (pcode, pline) FROM stdin;
    public          postgres    false    221   CJ       ?          0    24617    shift_master 
   TABLE DATA           P   COPY public.shift_master (scode, sname, brlu, start_time, end_time) FROM stdin;
    public          postgres    false    222   vJ       E          0    49153 	   tool_data 
   TABLE DATA           D   COPY public.tool_data (id, tool_no, machine_no, reason) FROM stdin;
    public          postgres    false    228   �J       @          0    24624    tool_master 
   TABLE DATA           F   COPY public.tool_master (tno, tname, ttype, tlpc, maccat) FROM stdin;
    public          postgres    false    223   +K       P           0    0    logincredentials_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logincredentials_id_seq', 14, true);
          public          postgres    false    224            Q           0    0    machine_operator_sno_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.machine_operator_sno_seq', 111, true);
          public          postgres    false    219            R           0    0    tool_data_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.tool_data_id_seq', 12, true);
          public          postgres    false    227            �           2606    24632 $   employee_master employee_master_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.employee_master
    ADD CONSTRAINT employee_master_pkey PRIMARY KEY (employee_code);
 N   ALTER TABLE ONLY public.employee_master DROP CONSTRAINT employee_master_pkey;
       public            postgres    false    216            �           2606    32774 &   logincredentials logincredentials_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.logincredentials
    ADD CONSTRAINT logincredentials_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.logincredentials DROP CONSTRAINT logincredentials_pkey;
       public            postgres    false    225            �           2606    40987    machine_data machine_data_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.machine_data
    ADD CONSTRAINT machine_data_pkey PRIMARY KEY (machine_no);
 H   ALTER TABLE ONLY public.machine_data DROP CONSTRAINT machine_data_pkey;
       public            postgres    false    226            �           2606    24634 "   machine_master machine_master_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.machine_master
    ADD CONSTRAINT machine_master_pkey PRIMARY KEY (mno);
 L   ALTER TABLE ONLY public.machine_master DROP CONSTRAINT machine_master_pkey;
       public            postgres    false    217            �           2606    24636 &   machine_operator machine_operator_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.machine_operator
    ADD CONSTRAINT machine_operator_pkey PRIMARY KEY (sno);
 P   ALTER TABLE ONLY public.machine_operator DROP CONSTRAINT machine_operator_pkey;
       public            postgres    false    218            �           2606    24640    part_master part_master_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.part_master
    ADD CONSTRAINT part_master_pkey PRIMARY KEY (pcode);
 F   ALTER TABLE ONLY public.part_master DROP CONSTRAINT part_master_pkey;
       public            postgres    false    220            �           2606    24642 ,   product_line_master product_line_master_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.product_line_master
    ADD CONSTRAINT product_line_master_pkey PRIMARY KEY (pcode);
 V   ALTER TABLE ONLY public.product_line_master DROP CONSTRAINT product_line_master_pkey;
       public            postgres    false    221            �           2606    24644    shift_master shift_master_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.shift_master
    ADD CONSTRAINT shift_master_pkey PRIMARY KEY (scode);
 H   ALTER TABLE ONLY public.shift_master DROP CONSTRAINT shift_master_pkey;
       public            postgres    false    222            �           2606    49160    tool_data tool_data_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tool_data
    ADD CONSTRAINT tool_data_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.tool_data DROP CONSTRAINT tool_data_pkey;
       public            postgres    false    228            �           2606    24648    tool_master tool_master_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.tool_master
    ADD CONSTRAINT tool_master_pkey PRIMARY KEY (tno);
 F   ALTER TABLE ONLY public.tool_master DROP CONSTRAINT tool_master_pkey;
       public            postgres    false    223            8   �   x�U�;A��Cx���ƸQ������Y�2�}�G�v�����<*Z��6�a���ˍ,�kN�����gq�v���%�~VP��R����P;l��ʘ�K�`x,s@�,l��8���컡���G(̰�c'/1���3����J	�!��6y      9   �  x���MO�<���S�X.Y��v��bh����Poc��(/E��;��B���6���5��3�TD��k�v���vk��[�ڱ�[�vS��m�pՒ㗵�𒝵�{1m۱(NR�J�>Y��RR�I��ne�5�8I�X���r��fm�	.��w��+Kx��
���$�'==���"���6��NGh)JK�Z�`� w[y��7��1��RԾ�P�����Kט��_�	��W�[[
g�p�C�?,��s���&G����}��F�l���+�����)��PJvg�!k�5'������"�����)F�ӣ��ƔF��4�/ 3�ƣh������rw(�P�G��v�]�����1��X;>��O�����Ȓ�da���Z �a�D����Hv�m	�'�2��)ů���].2�~V�p��$������P���������_��PI	�d�#(m�
�f��J�D&)�H"��k6�3���ƩQ�BBpu03K�^��Oɯ}�� ��cD F�n����������"	�D!��tu[�sS9[��^5<�w�"���;���k�.�!	K㢣p"	��
pb�����b5 .���sw,D����Oo�82� BAKmI��Wmڢ���]M2@��$��DЍ@�/
����'�F�MI!D�	��yp���~(��o?D�+p��AC0�#P^E�#	���+��4��E	E4�s+cS�}��:�NQxPTÑao
O>��[��v�
EE�!�������
E� ���'����![Ea@C
�^�Q��j��U:@���A �2��v�i��3м�̌����)�+��q�Ï-q�yƳrڔ��x@ٵ)<���� ��{�~�(�)�k���~g���ǫl@�i���h��+P���@���P:`5e~MM)�5ճ�[���1 �4e��?P����
g�	ޏ೦0�	@c7�6�ڒA�wMk���j�*k���!ĉj�fϢ��p%���C�(�,4#-ο,����cb�P�=T�"��?��� #߃;��(nh���u03���yq+�Qv�;�)�L�SaMɮ����Q��<[C;�@V��"�H�[x�列�yN��}�^��Qu�[�t`��k������b,��@Oi�{���_o�f'�����?�^�/      B   B  x�u�AoA�����+h�k{fz���@P��gl�(mS����g#.=�w��'?�D�7�cݪ��a-@|��᫿���姴���߯0HN Ic��9��B�Tu�么bv�������	k��G�~�Owo�7���c]o>�\��-Ct��)�*�U �� �ZH�ՃPb6�"$����ww�Ǳ[��FW�+��j��hu���k-�&sy;*,��i��x�ā��H��J.4��>bwxz�������m7��t�9-ӷ��4h��5��|i��MAZ+�#[�X�����G3�yrKE����z���_��e      C      x�74�44�c�pNK ���b���� h�v      :   �   x���A�@������f�D��";t[J*A�>5D�vNs�xo�{�R5e��U��L��e���F�<�'!.?y�,!����1�B9"�P������:d����%5���	�{T�^f�����z��U�<�>��*��a�&���D��G���{�
W]Z�m�3*�;۰K(��3���~)��˦�<�*Ȋb�l'�+����H����6�a|X~t      ;   �  x�Ř�N1���S N����{o� �*�
�KPI*Q	X����.��k'!P�6�����|��  y��@�5Be��V�����Q��g�����R��	E;f�4f���1B�ρ�"���k~g��M��.�0U��T/�V�r��o'ia��E��v��7�OwWG��,��Y4w���o�}?<
�������q:�q?����ERk&c-�'h7��'�	ý?��d �_bW!~1��
ITYA!�H�Z�`Ȕ0�����p�;9S��J�x�_9(͘CX��XG��ᑕ*�e��\6��l� RB��4XX�bt\���A�RT��[��*,Ņ0��^	�J`��˾�{��{�wf��z#*�x���
���Mopco�Ҳ 1���B$C<C�Đzv#@f��C��T�d����ϗ��ߖ;��`]�	 �w̳B,U�a+��ap(��>�<<�,�G��g=���?��G�DxE#�)�F���%5�;�\/-V�a}D�ۄ�ݦ��d��Ȣ�/�g{��������<	��j�A����8N����7z�K:��Z�B�UoC�#7�!r������x&��m�������𼴥��9n^�8q�=e_wq����+m(��G��>���~7oaQ��)������ߪ���GoU[�U�f���Pݍ+�Z1۱0�$GD�pr��O�!�ol�v���u���������"�j�� �"�� �����P�� S��/k0�P��n��ga��|����y�s�4����zL�L��"%����e�'<��k
�ɫ�'+[��:�`8�l���!*�"�܅��U�h�\�)y�_̤J����iK���Vg��q�ַȒ�%NA9��1'��(�z��-hn����Si����YYj,��e!�E�ҕ�S�Fs-gdq}�&��d]N'��?F|�:      =   G   x�3�05�,)�,�L����,���ҴR�������Ғ�LNC.##N442����9�38M�b���� &�>      >   #   x�3333�t**-��27�0�t��O������ _�m      ?   \   x�3�L�,*.Q(��L+�4�20Pp��402���������2�,�(�L��� ���42��30��3�,NM�σ)��bUfd U���� ��      E   9   x�34�L�/!�pcC��Ғ�R.C#NC�pC��0�2�4�7�L)N"�=... �	3      @   L   x�-�1
�@D�zr��<6�H6�f�M��Q�S�!�4Æ}��J��_'c=3�[k8�b�r)��B�FD/!�      