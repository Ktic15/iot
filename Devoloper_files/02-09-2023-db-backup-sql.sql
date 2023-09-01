PGDMP     6    4                {            iot_company_project001    15.2    15.2 2    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    215   �>       :          0    24598    employee_master 
   TABLE DATA           �   COPY public.employee_master (employee_code, employee_name, employee_designation, area_of_work, employee_address, employee_aadhaar, employee_mobile_no, function_manager, em_efficiency, employee_alternate_mobile_no) FROM stdin;
    public          postgres    false    216   Z?       C          0    32769    logincredentials 
   TABLE DATA           H   COPY public.logincredentials (id, username, password, role) FROM stdin;
    public          postgres    false    225   +D       D          0    40981    machine_data 
   TABLE DATA           _   COPY public.machine_data (machine_no, current_count, efficiency, efficiency_count) FROM stdin;
    public          postgres    false    226   �E       ;          0    24601    machine_master 
   TABLE DATA           c   COPY public.machine_master (mno, mname, mcat, mmnu, contdet, doc, mkva, mm_efficiency) FROM stdin;
    public          postgres    false    217   �E       <          0    24604    machine_operator 
   TABLE DATA           �   COPY public.machine_operator (sno, product_line, date_, shift, machine_no, operator_id, part_no, shift_supervisor_name, time_, operator_change, old_alloc, mo_efficiency, mo_count, shift_supervisor_id, tool_no) FROM stdin;
    public          postgres    false    218   �F       >          0    24611    part_master 
   TABLE DATA           e   COPY public.part_master (pcode, pdes, cpn, proline, npccps, pdesc, efficiency_tolarance) FROM stdin;
    public          postgres    false    220   �J       ?          0    24614    product_line_master 
   TABLE DATA           ;   COPY public.product_line_master (pcode, pline) FROM stdin;
    public          postgres    false    221   AK       @          0    24617    shift_master 
   TABLE DATA           P   COPY public.shift_master (scode, sname, brlu, start_time, end_time) FROM stdin;
    public          postgres    false    222   �K       F          0    49153 	   tool_data 
   TABLE DATA           D   COPY public.tool_data (id, tool_no, machine_no, reason) FROM stdin;
    public          postgres    false    228   �K       A          0    24624    tool_master 
   TABLE DATA           F   COPY public.tool_master (tno, tname, ttype, tlpc, maccat) FROM stdin;
    public          postgres    false    223   <L       Q           0    0    logincredentials_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logincredentials_id_seq', 17, true);
          public          postgres    false    224            R           0    0    machine_operator_sno_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.machine_operator_sno_seq', 116, true);
          public          postgres    false    219            S           0    0    tool_data_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.tool_data_id_seq', 12, true);
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
       public            postgres    false    223            9   �   x�U�;A��Cx���ƸQ������Y�2�}�G�v�����<*Z��6�a���ˍ,�kN�����gq�v���%�~VP��R����P;l��ʘ�K�`x,s@�,l��8���컡���G(̰�c'/1���3����J	�!��6y      :   �  x���KS�:��ʯ�2l<���d.3@2)Lq7l6���P~@��ߖ�N����T[U�ɑ�_w'tC�͜ļ�Z������!���_/Y��u��,M���/jS�tƿ񷬴g��͋nێy~�P*����H)%eD�45E��W]1��~>	]W�+]w//]�W~��v�8Q:���U��1Ҏ�v�؏l�+���V:8RzO3t�&�&�n�f]�-i��	I��I�$�)%���Y��+kQ�1z��E/�ui����?����r��2>��-�ۜ�*���V9m�l�Pn�U� ���f�]:�ua6�_��W�O����8�f�~@m
�%y����c}
�l*$����Em=R�6GK�I �_�k�b�F�FA7�'|]$��%��*#_�`��L����j��4�����ܜz4v�ܬ��T���r�nWd8�d���&qc�~ViN��'���� b�{���� �����%���CL�8f����M�f˳�/b�Im��m��cͺ2z��8A�l��-��\/)uه��=���-!�]�v�-;Zä_Ñ�����z��m��te������x�IDr�HNS��i�ݦ&�AOb|���B�|n%}5�
|��w]�%�%��J�i��� 8���;S�ۼ�"��=�V$�J�QmH���}y��D��0���;�lv�٘bP!�(X���.)�SC�٢�7 �+�y"܀vǢօ��n�X1��p�G�� 3�:�Ŷ�C6�B�Pʿ�6t�c��;�u0�!n(��
0j��e�?d�&Ƅ�m�j
,����B��)
�����Z�I(!L(�	�}��������%�}�z�l�v��
���m����Y}��2d����J��������V�^>jF�
�Bl���[��q<`�E.3�>�(�Sz��wj��3!4D����ټg�E��~�C���T,h�/+��N���G��3g��Yɨl0M���g��TY6d� lD���'��neχ�!zD���ֹ˨�i��,�*���8D �H|�wI��o�@ڣ�[<zU"D������|rw�^�"=Ƒ.B�ә��<�%��FNg�">FOea@�t�����;���GA� 6W~�u�C�Q�k�Z�tv��w��⳰y3�,�Y,}Jwo�������ّ�ݱzZ���A���+�V"M��~��5�w&���E�      C   E  x�m��nA���s�����3��RZ��(U��x����*I��YąC|����l�Ծo~t/y����I1�%��>�����z/�w��z�Q� �9ЖC�>#4��h\���M1Z��μP� ���a�m;�>�Wo�o��<��_ׇ�Dt��A�$B�Δ�BK�j�*�f�AMh���S����n�\{G�����vw���x=�6����9}<J�Q��-��Ym�PKI$D��dJ�̭��V�e�Ъ$m���[p�5^Ϳ�x5�z;��.����5�j�M��X��
N��"C^> %��G��]�t���6�p      D      x�74�44�c�pNK ���b���� h�v      ;   �   x����
�@��w��'�;?f-��$��"[��J)Eo_JZRHs݌.>��3�m��(��`�9�Y~��\z5[���NDI
�#���*��<���+��KFE�o�� �~/T���6Y�KA~5��\��u8=���f�Q�v�t�ѣ��	}����Z�r�m��~�k��a�pz>��4��/��sǫ$+�^��л���-鑧�R(��g����=V��õ�TOw5ɩ#{��!c����5      <   �  x�Ř�N1���S��Z�D3�����=T����P�J�"!Ļw��I�^;Y�R�ֿ�χ�cP �s0s4���e��Z-�zu�D�
@���3~�����?�(b�1���$��r�x��(u]�;c�l����SP
Se=��U�jzZ=����0lu�"�|s��jno/��Yا��Us�<�~�Y�/������Csl��q��z�����ERk&c-�'h��ӄ�ޞS�2ޮ1�+�?��Q�$����U$a�K0dJ�RrP�X~q�;9S��J�x���f�!,qt���E���J�2p~
6��l� RB��o4�X�bt\���A�RT��[�CDUX�a�H�� I�}!�1��FOf��z#*�X�\
QHRpԦ�����,@�p3���&1�^�]��p�`s*T��WR��Kȭo˝w� �-�Յ��K��r�J�|��?G'���W���"X���DE�?��G}"|EO�Sʍ���Kj�;��n-V�a{D�w���ߦ:�d��Ȣ�^��������I*��v�����
)e�;p�Y?*i�7z�K:��^�BxU�C�#w�!r��	�'�=6�I{l[�W�K��#</���=��g��Suw�o��RC��>��q�������EU�K�����w߽U����nU{�U�aq}X��ƕL���X�a�#�8y���'��7�Ҹ�m�V��e`*$���nG��#����!��n/3��>�����9T�q������.>yqz���9L^�`�q=�}͂�"%����e�'<��[
�ś/V�B�p�p �
_wBT.E2��ˋ6�����¼�I��˷�Ӗ^?q���.Pw�`���%�K\�r��cN��(�Z��4�pyY��i����YYj,��e!�F�ҕ��Fs-gdq}L�U�e�dY�N��L��h�;A�.�ZVT[~]�L��[=���b6��_��      >   �   x�]�M�0���SpMhe�kÆ����!���[�qa2�L�̌��iep��l�������}��Bk�)C����_�Xᜳ8s�#��j'qZ8(��^4��Tc�똶�ʙM��Ǯxu�J�[;�׵���e/�xp�.�      ?   6   x�3333�t**-��27�0�t��O��24�tN,J��S�H�$�S��b���� ��,      @   \   x�3�L�,*.Q(��L+�4�20Pp��402���������2�,�(�L��� ���42��30��3�,NM�σ)��bUfd U���� ��      F   9   x�34�L�/!�pcC��Ғ�R.C#NC�pC��0�2�4�7�L)N"�=... �	3      A   x   x���A
�@E��)<AI�����t#”)������χ���R1x��!,�b%9�j��V��}���`3�T/����L����ꔿiVJ�_�X�O]��v����w�n5�     