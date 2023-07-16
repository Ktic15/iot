PGDMP         (                {            iot_company_project001    15.2    15.2 +    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    24576    iot_company_project001    DATABASE     �   CREATE DATABASE iot_company_project001 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
 &   DROP DATABASE iot_company_project001;
                postgres    false                        3079    24577 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            ?           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
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
    functional_manager character varying(40) NOT NULL,
    em_efficiency integer NOT NULL
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
       public          postgres    false    225            @           0    0    logincredentials_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.logincredentials_id_seq OWNED BY public.logincredentials.id;
          public          postgres    false    224            �            1259    40981    machine_data    TABLE     �   CREATE TABLE public.machine_data (
    machine_no character varying(255) NOT NULL,
    current_count character varying(255) NOT NULL,
    efficiency integer NOT NULL,
    efficiency_count character varying(255) NOT NULL
);
     DROP TABLE public.machine_data;
       public         heap    postgres    false            �            1259    24601    machine_master    TABLE     c  CREATE TABLE public.machine_master (
    mno character varying(40) NOT NULL,
    mname character varying(40) NOT NULL,
    mcat character varying(40) NOT NULL,
    mmnu character varying(40) NOT NULL,
    contdet character varying(40) NOT NULL,
    doc character varying(40),
    mkva character varying(40) NOT NULL,
    mm_efficiency integer NOT NULL
);
 "   DROP TABLE public.machine_master;
       public         heap    postgres    false            �            1259    24604    machine_operator    TABLE     5  CREATE TABLE public.machine_operator (
    sno integer NOT NULL,
    product_line character varying(40) NOT NULL,
    date_ date NOT NULL,
    shift character varying(40) NOT NULL,
    machine_no character varying(40) NOT NULL,
    operator_id character varying(40) NOT NULL,
    part_no character varying(40) NOT NULL,
    shift_supervisor_name character varying(40) NOT NULL,
    time_ time without time zone NOT NULL,
    operator_change character varying(10) NOT NULL,
    old_alloc integer,
    mo_efficiency integer NOT NULL,
    mo_count integer NOT NULL
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
       public          postgres    false    218            A           0    0    machine_operator_sno_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.machine_operator_sno_seq OWNED BY public.machine_operator.sno;
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
       public         heap    postgres    false            �            1259    24624    tool_master    TABLE     �   CREATE TABLE public.tool_master (
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
       public          postgres    false    219    218            -          0    24587    change_reason 
   TABLE DATA           ;   COPY public.change_reason (sno, reason, time_) FROM stdin;
    public          postgres    false    215   B6       .          0    24598    employee_master 
   TABLE DATA           �   COPY public.employee_master (employee_code, employee_name, employee_designation, area_of_work, employee_address, employee_aadhaar, employee_mobile_no, functional_manager, em_efficiency) FROM stdin;
    public          postgres    false    216   �6       7          0    32769    logincredentials 
   TABLE DATA           H   COPY public.logincredentials (id, username, password, role) FROM stdin;
    public          postgres    false    225   D;       8          0    40981    machine_data 
   TABLE DATA           _   COPY public.machine_data (machine_no, current_count, efficiency, efficiency_count) FROM stdin;
    public          postgres    false    226   �<       /          0    24601    machine_master 
   TABLE DATA           c   COPY public.machine_master (mno, mname, mcat, mmnu, contdet, doc, mkva, mm_efficiency) FROM stdin;
    public          postgres    false    217   �<       0          0    24604    machine_operator 
   TABLE DATA           �   COPY public.machine_operator (sno, product_line, date_, shift, machine_no, operator_id, part_no, shift_supervisor_name, time_, operator_change, old_alloc, mo_efficiency, mo_count) FROM stdin;
    public          postgres    false    218   �=       2          0    24611    part_master 
   TABLE DATA           e   COPY public.part_master (pcode, pdes, cpn, proline, npccps, pdesc, efficiency_tolarance) FROM stdin;
    public          postgres    false    220   ?       3          0    24614    product_line_master 
   TABLE DATA           ;   COPY public.product_line_master (pcode, pline) FROM stdin;
    public          postgres    false    221   [?       4          0    24617    shift_master 
   TABLE DATA           P   COPY public.shift_master (scode, sname, brlu, start_time, end_time) FROM stdin;
    public          postgres    false    222   �?       5          0    24624    tool_master 
   TABLE DATA           F   COPY public.tool_master (tno, tname, ttype, tlpc, maccat) FROM stdin;
    public          postgres    false    223   �?       B           0    0    logincredentials_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logincredentials_id_seq', 14, true);
          public          postgres    false    224            C           0    0    machine_operator_sno_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.machine_operator_sno_seq', 19, true);
          public          postgres    false    219            �           2606    24632 $   employee_master employee_master_pkey 
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
       public            postgres    false    222            �           2606    24648    tool_master tool_master_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.tool_master
    ADD CONSTRAINT tool_master_pkey PRIMARY KEY (tno);
 F   ALTER TABLE ONLY public.tool_master DROP CONSTRAINT tool_master_pkey;
       public            postgres    false    223            -   \   x�U�1�0��>��|�1�Y�@�����ە�>�g�n�z^�Sz�R���&�K���X��:iO�DH��չ8=�K���#�ga�$      .   �  x���Ks�8��ʯВl<�C/�I*�
�2��(A��P~���ϕIW��&���UeN]������y������4ݴ[]Y�7�nv��K[��_�����J�Mn��iZ�	�\Ș&�IR%��'���vcj}�%	��a,�}p�{kr����-\���-
��|;I��	LOxz,�m0ӹ��{��%1-�kqFfAf6r��o�ֆ(*LQ��L���������H��ȭ]���<N1����8@�X҉�M.�=��}���q2k�v�%�@V�腘^�(Y�5t���"ab�_\�\q��t�*������1��IE�r�L��ꑸĸ����8�K$�D�Yb���I�Co�Q�{��󭥣n��~���@�,�'c��� ��v�q�M��=�/�c�&X�j@G�·2_�)�/��k��T�_�2��� �V�IbP�T"�{�
��];���z�*A8B�4%sJS���9�,����	"�kĈԻ��SWF��0�!!�:x�+���k��}�� ��c�F�v�¹eݹ�È"�D!�ߵU��]ZSЛN5��w#���;����G�t�$,�É@pK��.7��N/�=���-<wǌE$&t�����"�K�<�r��]���������#� �@�/s]ӧ.DƦ�"|���~��ھǁ!�Cb�~�`IL&�䥅@0�*�1^$F�#d	�����8�j�qJ��D�����U��N���$8R�M����i����=W�� 2�0�!q�RM��P0HQtJ��;��l��\R@�6 �꣛�^�2�� w�O���]]w������|���%b�8u�S���ڝE���/�ʦ����;��?��>������|�ߧ��G}"gw�J{������;���q}6vB��*��
�ip�֔k�{̻�F�fS���g����CO�Jw���|V�v��dӃ)�~[7�l�)W�4�Oo``PBw������N����!t(}
�����IfJ���Ԇ�By��Y�@���~:򣸋O���\w�B��Wץb)f��s�ɯ`f_s�2i�b��:�lq.���wC�9����sr�99t���
/yA���к{l��_x��������H��      7   B  x�u�AoA�����+h�k{fz���@P��gl�(mS����g#.=�w��'?�D�7�cݪ��a-@|��᫿���姴���߯0HN Ic��9��B�Tu�么bv�������	k��G�~�Owo�7���c]o>�\��-Ct��)�*�U �� �ZH�ՃPb6�"$����ww�Ǳ[��FW�+��j��hu���k-�&sy;*,��i��x�ā��H��J.4��>bwxz�������m7��t�9-ӷ��4h��5��|i��MAZ+�#[�X�����G3�yrKE����z���_��e      8      x�7�440�a�=... #�      /   �   x���A�@������f�D��";t[J*A�>5D�vNs�xo�{�R5e��U��L��e���F�<�'!.?y�,!����1�B9"�P������:d����%5���	�{T�^f�����z��U�<�>��*��a�&���D��G���{�
W]Z�m�3*�;۰K(��3���~)��˦�<�*Ȋb�l'�+����H����6�a|X~t      0   N  x���Mk�@�ϓ_Q<��23��=�H�C��!n-x(]!����J�lL
��3Y�����7΂�ځw�@�;�@& ��A��{��_�{��j��2{�S�c�rg�Q)��
�����cܥ�m�6�VRn���m��x�NEgd��2��a�|y5��m2���MS+/��}����X��m�K�wR�����=qF��3���%|<���#��ؤ-,ڒlƢ-bp�8�1�,��m�����5�����}��b���I�!�T�/m���*����~�	\!�,Р�ʅo>U
z����{0�%\`���܇u�r�����?���      2   J   x�36�42"#(�L��440�2rP������9geI)gifz&'�gq�W���rf�Wf&����e����qqq +#�      3   $   x�3333�L/M��27�0�L+-I)-����� l�D      4   \   x�3�,�(�LQ(��L+ᴰ20P��442���������2�,NM�σ)44�X@��B�r�e�@U���s��+k0������� ��      5   *   x�K�/M"N �����dfdBx���@n>X4�+F��� ��     