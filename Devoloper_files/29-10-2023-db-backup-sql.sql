PGDMP     4                	    {            iot_company_project001    15.2    15.2 2    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            L           1262    24576    iot_company_project001    DATABASE     �   CREATE DATABASE iot_company_project001 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
 &   DROP DATABASE iot_company_project001;
                postgres    false                        3079    24577 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            M           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    24587    change_reason    TABLE     �   CREATE TABLE public.change_reason (
    sno integer,
    reason character varying(150) NOT NULL,
    time_ time without time zone
);
 !   DROP TABLE public.change_reason;
       public         heap    postgres    false            �            1259    24598    employee_master    TABLE       CREATE TABLE public.employee_master (
    employee_code character varying(40) NOT NULL,
    employee_name character varying(40) NOT NULL,
    employee_designation character varying(40) NOT NULL,
    area_of_work character varying(40) NOT NULL,
    employee_address character varying(40),
    employee_aadhaar character varying(40),
    employee_mobile_no character varying(40),
    function_manager character varying(40) NOT NULL,
    em_efficiency integer,
    employee_alternate_mobile_no character varying(40)
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
       public          postgres    false    225            N           0    0    logincredentials_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.logincredentials_id_seq OWNED BY public.logincredentials.id;
          public          postgres    false    224            �            1259    40981    machine_data    TABLE     �  CREATE TABLE public.machine_data (
    machine_no character varying(255) NOT NULL,
    current_count character varying(255) NOT NULL,
    efficiency integer NOT NULL,
    efficiency_count character varying(255) NOT NULL,
    status character varying(40),
    previous_count character varying(40),
    machine_start_time time without time zone,
    previous_machine_start_time time without time zone
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
    tool_no character varying(40),
    machine_start_time time without time zone
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
       public          postgres    false    218            O           0    0    machine_operator_sno_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.machine_operator_sno_seq OWNED BY public.machine_operator.sno;
          public          postgres    false    219            �            1259    24611    part_master    TABLE     V  CREATE TABLE public.part_master (
    pcode character varying(40) NOT NULL,
    pdes character varying(40) NOT NULL,
    cpn character varying(40) NOT NULL,
    proline character varying(40) NOT NULL,
    npccps character varying(40) NOT NULL,
    pdesc character varying(40) NOT NULL,
    efficiency_tolarance integer DEFAULT 10 NOT NULL
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
       public          postgres    false    228            P           0    0    tool_data_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.tool_data_id_seq OWNED BY public.tool_data.id;
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
       public          postgres    false    224    225    225            �           2604    24627    machine_operator sno    DEFAULT     |   ALTER TABLE ONLY public.machine_operator ALTER COLUMN sno SET DEFAULT nextval('public.machine_operator_sno_seq'::regclass);
 C   ALTER TABLE public.machine_operator ALTER COLUMN sno DROP DEFAULT;
       public          postgres    false    219    218            �           2604    49156    tool_data id    DEFAULT     l   ALTER TABLE ONLY public.tool_data ALTER COLUMN id SET DEFAULT nextval('public.tool_data_id_seq'::regclass);
 ;   ALTER TABLE public.tool_data ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            9          0    24587    change_reason 
   TABLE DATA           ;   COPY public.change_reason (sno, reason, time_) FROM stdin;
    public          postgres    false    215   �?       :          0    24598    employee_master 
   TABLE DATA           �   COPY public.employee_master (employee_code, employee_name, employee_designation, area_of_work, employee_address, employee_aadhaar, employee_mobile_no, function_manager, em_efficiency, employee_alternate_mobile_no) FROM stdin;
    public          postgres    false    216   �@       C          0    32769    logincredentials 
   TABLE DATA           H   COPY public.logincredentials (id, username, password, role) FROM stdin;
    public          postgres    false    225   �E       D          0    40981    machine_data 
   TABLE DATA           �   COPY public.machine_data (machine_no, current_count, efficiency, efficiency_count, status, previous_count, machine_start_time, previous_machine_start_time) FROM stdin;
    public          postgres    false    226   .G       ;          0    24601    machine_master 
   TABLE DATA           c   COPY public.machine_master (mno, mname, mcat, mmnu, contdet, doc, mkva, mm_efficiency) FROM stdin;
    public          postgres    false    217   jG       <          0    24604    machine_operator 
   TABLE DATA           �   COPY public.machine_operator (sno, product_line, date_, shift, machine_no, operator_id, part_no, shift_supervisor_name, time_, operator_change, old_alloc, mo_efficiency, mo_count, shift_supervisor_id, tool_no, machine_start_time) FROM stdin;
    public          postgres    false    218   pH       >          0    24611    part_master 
   TABLE DATA           e   COPY public.part_master (pcode, pdes, cpn, proline, npccps, pdesc, efficiency_tolarance) FROM stdin;
    public          postgres    false    220   �L       ?          0    24614    product_line_master 
   TABLE DATA           ;   COPY public.product_line_master (pcode, pline) FROM stdin;
    public          postgres    false    221   ?M       @          0    24617    shift_master 
   TABLE DATA           P   COPY public.shift_master (scode, sname, brlu, start_time, end_time) FROM stdin;
    public          postgres    false    222   �M       F          0    49153 	   tool_data 
   TABLE DATA           D   COPY public.tool_data (id, tool_no, machine_no, reason) FROM stdin;
    public          postgres    false    228   �M       A          0    24624    tool_master 
   TABLE DATA           F   COPY public.tool_master (tno, tname, ttype, tlpc, maccat) FROM stdin;
    public          postgres    false    223   MN       Q           0    0    logincredentials_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logincredentials_id_seq', 18, true);
          public          postgres    false    224            R           0    0    machine_operator_sno_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.machine_operator_sno_seq', 120, true);
          public          postgres    false    219            S           0    0    tool_data_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.tool_data_id_seq', 13, true);
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
       public            postgres    false    223            9   �   x�U�;A��Cx���ƸQ������Y�2�}�G�v�����<*Z��6�a���ˍ,�kN�����gq�v���%�~VP��R����P;l��ʘ�K�`x,s@�,l��8���컡���G(̰�c'/1���3����J	�!��6y      :   �  x���OW�<���Sd��NӴI�t^=Ψ G<��M�J#�x�G���)8�>8�-�6��$���K�G>yS�bJ��h��F�vĮ���ԫ�Ml��b���������_��ݱ�:�Ϧ��0�Ғ��ΒXk�T��xfie^L��ﳻ� �}�.L�<?7�Y�����D���%-v���@�P�_����L�ϝtx��f�MM�)������S{��$I-}$�ЦR��<�U�/�E���H/���Y4��#�/�?���;so��2�HhK��&���o�+�U��*]���]���@�bJ#�ν�fa׆_�E�--��G��q����)$�fi����)d���HFC��g��y�0\����:R�K�l�J�FA7tG�]�T�%ǫ"%_�`���d������0�_�1�x��j;�WUJ*|�6|;w{�+2}1Lc|=��~���M=��k駊 a���� jڐ���%w��#L�$a�=�ի)�g�?���S�
A�{��Ua�&�~��
#[B���S,����!�Wa[Al���i3oh���TDW���`����3~b
�����N!�+Dr�m��]�fk��~�ƷԄoS,L��NR��P�+���6����jzJ��;� �)�OȐ��bUg�!���S�AaEa��� ��T��Mς�V0
FP:zk��63�j��A?�윂|f)7���:���DC�?��1)�����u�1��q�G�pAfVe��
BtY��C�I�W8З�������ܐ��QQ�I3e�	B��A�)�(p�2fA��(�d��׬���Z�A	aBCL������٪��X��gl��l��Gh�2q�j��b���K��G<И����bp����Y>֌bL��Qam6�m�ê�b�fDmіO���c�u��!�SFT�O�m瘴�a��#8�ҧ`B}^��w�{�<F��1$(Ay�~IsFi��jS�<-�H�.Ka#F���xS���;���b�1��pĽ�nS�ej�����]�}"��$җ>����:�5�n��YDT�U�/( ���͓���P�Ez�#]D�7�Yjrv���E|�"�����7��nM�v��<AA.�^����YCi�}�y�PؽتK�!>ǈ����2_�f��ퟻl���o?v����4=��s�Q��j�䇁�'1��/���9ok_����>.� ���M����.r{���HmN�@�����i���>]w�`0���=      C   �  x�m��nT1F��>�݂'��n;�2@5� ��'��L5���Ć�xi}��僃�����7��j�R�tE�w����a��4����[�|3� H�l��($�3B�l޳J/�N���ʍ�y9��������t�:��<�ϫ͗��o����f�A�Y g1Ė��P�Ck�Ԅ��9ըnX^��Outa�_���ow��2_�,g���b�)}8O2!�1F��ڬ�b����!8��C
D�J���b����G]�e��l���V��Wt��Ƀ�hbT��QS��fҘ]d ���*:6r�������E�U��p���Ԟ�1���t}�}�L�$U��J�����k���hu>DR ��d}����2���\w����8�����      D   ,   x�74�44@���̲T�?�
7��B�g�|� �i      ;   �   x����
�@��w��'�;?f-��$��"[��J)Eo_JZRHs݌.>��3�m��(��`�9�Y~��\z5[���NDI
�#���*��<���+��KFE�o�� �~/T���6Y�KA~5��\��u8=���f�Q�v�t�ѣ��	}����Z�r�m��~�k��a�pz>��4��/��sǫ$+�^��л���-鑧�R(��g����=V��õ�TOw5ɩ#{��!c����5      <     x�Ř�n�:ǯ�(v�m@R_��(���a@oR��nt@;(����d'�d�u��p���~���(�$�0h�Z[#�QV��jq��X��@\��K�C�ߤ_�A�Re��������&a~�"�.+-�1z�#�|w���~�_�3Y���w_���~}����?�;�o��ӯ���M/���������L�d��AoEx���(�L�ڶ����*c�?���ӈA8��8�B|e0� �"�r����uB"S"�Lʱ&�O}/�a�b���J�s[J3EΠt��#G�P�F�9h�@}� ò	�<K		���h�`��"U�99��E37�`� �qT�31"L8n��M�Ր�{M08�������#�1*�٦c�QeN��&����-j�,s�x��d�cØӮn�Lh�ցasZT�p��E��"��#�>���(_��C��ЎC��hWI���篳����7����x�����T��!**��1�v�D��$1����c!��N�\>,����f�qV{sF���Z���5�IZ:�����>��-M�7)Ņř0+�&y.���<��e�L�nz�����l<RGj�@��,��g�`b^����B��/��������j���4�.}
6K������}O'��sO�k\�T����4����١N���-qZ�������^�c���1&�LB�ʝ�ޤ�>#��|�Ɯ�F�6�$M�]�myı�"�'���(=o0H��xYQXOP� 6ғ���9'>=t�m��F�I8�ꁴ�*/�J���9ǉ�{���+۠[��pP�b"G�&M&��v}f8��}�'O��T��z��2ͱv�}�8���
T�x��م⊬��l�sO�Ǘ^I��gw^�ˊSSq%�^�!�n�]�h4�y^��2qE�H-�&d �.E�����X#qQι�*d�35�U�=����=�LO�{R��ؚ>�p6�~���D����C�T��c�gO{Ϟ׶-�ّ]���s������UUU�h��"      >   �   x�uN�
�0<O��?��э��Yz��K�m�R�.��7E� 3�2�k+�!-��#�]���K�s�J
��l�|��!��Z�6Bi�6��㈒�|�E3���}���ҺUYS��a���>\���o��ܮ�z͒$�B���V��E4X      ?   6   x�3333�t**-��27�0�t��O��24�tN,J��S�H�$�S��b���� ��,      @   \   x�3�L�,*.Q(��L+�4�20Pp��402���������2�,�(�L��� ���42��30��3�,NM�σ)��bUfd U���� ��      F   L   x�34�L�/!�pcC��Ғ�R.C#NC�pC��0�2�4�7�L)N".CcN'C��"�(TY
W� ��"      A   x   x���A
�@E��)<AI�����t#”)������χ���R1x��!,�b%9�j��V��}���`3�T/����L����ꔿiVJ�_�X�O]��v����w�n5�     