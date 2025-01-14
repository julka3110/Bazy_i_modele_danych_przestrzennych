-- slowniki potrzebne do ot_tcpk_a

create table ot_zrodlodanych (
id text primary key,
nazwa text);

insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychGeodezyjnychGrawimetrycznych','GEOS');
insert into ot_zrodlodanych(nazwa,id) values ('ewidencjaGruntowlBudynkow','EGiB');
insert into ot_zrodlodanych(nazwa,id) values ('geodezyjnaEwidencjaSieciUzbrojeniaTerenu','GESUT');
insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychPandwowegoRejedruGranic','PRG');
insert into ot_zrodlodanych(nazwa,id) values ('panstwowyRejesrNazwGeograficznych','PRNG');
insert into ot_zrodlodanych(nazwa,id) values ('ewidencjaMiejscowosciUlicAdresow','EMIJiA');
insert into ot_zrodlodanych(nazwa,id) values ('rejestrCenWartosciNieruchomosi','RCiWN');
insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychOgolnogeograficznych','BDO');
insert into ot_zrodlodanych(nazwa,id) values ('ortofotomapa','Ort');
insert into ot_zrodlodanych(nazwa,id) values ('mapaZasadnicza','Mz');
insert into ot_zrodlodanych(nazwa,id) values ('mapaTopograficzna10k','Mtpl10');
insert into ot_zrodlodanych(nazwa,id) values ('mapaTopograficzna50k','Mtp50');
insert into ot_zrodlodanych(nazwa,id) values ('vmapLeve12PierwszejEdycji','VMAPL2_v1');
insert into ot_zrodlodanych(nazwa,id) values ('vmapLeve12DrugiejEdycji','VMAPL2_v2');
insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychTopograficznych','TBD');
insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychCLC','CORINE');
insert into ot_zrodlodanych(nazwa,id) values ('centralnyRejestrFormOchronyPrzyrody','CRFOP');
insert into ot_zrodlodanych(nazwa,id) values ('bankDanychDrogowych','BOD');
insert into ot_zrodlodanych(nazwa,id) values ('bazaDanychWglnstrK1','BDOT500');
insert into ot_zrodlodanych(nazwa,id) values ('krajowySystemObszarowChronionych','KSOCH');
insert into ot_zrodlodanych(nazwa,id) values ('lesnaMapaNumeryczna',' LMN');
insert into ot_zrodlodanych(nazwa,id) values ('mapaPodzialuHydrograficznegoPolski','MPHP');
insert into ot_zrodlodanych(nazwa,id) values ('bazyDanychPKP','PKP');
insert into ot_zrodlodanych(nazwa,id) values ('rejestrZabytkow','RZAB');
insert into ot_zrodlodanych(nazwa,id) values ('krajowyRejestrUrzedowyPodzialuTerytorialnegoKraju','TERYT');
insert into ot_zrodlodanych(nazwa,id) values ('pomiarStereoskopowy','Str');
insert into ot_zrodlodanych(nazwa,id) values ('pomiarTerenowy','Tm');

create table ot_rodzajreprgeom (
id text primary key,
nazwa text);

insert into ot_rodzajreprgeom(nazwa,id) values( 'srodekGeometryczny' , 'SG');
insert into ot_rodzajreprgeom(nazwa,id) values( 'miejsceCharakterystyczne' , 'MC');
insert into ot_rodzajreprgeom(nazwa,id) values( 'punktUmowny' , 'PU');
insert into ot_rodzajreprgeom(nazwa,id) values( 'osGeometryczna' , 'OG');
insert into ot_rodzajreprgeom(nazwa,id) values( 'osInterpolowana' , 'OI');
insert into ot_rodzajreprgeom(nazwa,id) values( 'liniaUmowna' , 'LU');
insert into ot_rodzajreprgeom(nazwa,id) values( 'sztucznyLacznik' , 'SL');
insert into ot_rodzajreprgeom(nazwa,id) values( 'krawedz' , 'KR');
insert into ot_rodzajreprgeom(nazwa,id) values( 'zarysPodstawy', 'ZP');
insert into ot_rodzajreprgeom(nazwa,id) values( 'zasiegUmowny' , 'ZU');
insert into ot_rodzajreprgeom(nazwa,id) values( 'maksymalnyZasieg' , 'MA');
insert into ot_rodzajreprgeom(nazwa,id) values( 'minimalnyZasieg' , 'MI');
insert into ot_rodzajreprgeom(nazwa,id) values( 'sredniZasieg' , 'SZ');

create table ot_katdokladnosci (
id text primary key,
nazwa text);

insert into ot_katdokladnosci(id,nazwa) values ('Dok','dokladny');
insert into ot_katdokladnosci(id,nazwa) values ('Prz','przyblizony');
insert into ot_katdokladnosci(id,nazwa) values ('Npw','niepewny');

create table bt_identyfikator (
	id serial primary key,
	lokalnyid text not null
);

-- ot_tcpk_a

create table ot_tcpk_a (
	id serial primary key,
	nazwa text not null,
	-- atrybuty z ot_terenychronione
	geometria geometry(Polygon,2180) not null,
	idKSOCH text,
	-- atrybuty z ot_obiekttopograficzny
	idiip integer not null references bt_identyfikator(id),
	czyobiektbdoo boolean  not null,
	x_kod text  not null,
	x_katdoklgeom text not null references ot_katdokladnosci(id),
	x_doklgeom float, 
	x_zrodlodanychg text  not null references ot_zrodlodanych(id),
	x_zrodlodanycha text  not null references ot_zrodlodanych(id),
	x_rodzajreprgeom text  not null references ot_rodzajreprgeom(id),
	x_uwagi text, 
	x_uzytkownik text not null,
	x_aktualnoscg date not null,
	x_aktualnosca date not null,
	x_cyklzycia date not null,
	x_datautworzenia date not null,
	x_informdodatkowa text 
);

-- slowniki potrzebne do ot_ptwp_a

create table ot_rodzajobszaruwody (
	id text primary key,
	nazwa text
);

insert into ot_rodzajobszaruwody values ('Pm','wodyMorskie');
insert into ot_rodzajobszaruwody values ('Pp','wodyPlynace');
insert into ot_rodzajobszaruwody values ('Ps','wodyStojace');

create table ot_zbiornikwodny (
	id serial primary key,
	idiip integer not null references bt_identyfikator(id), 
	idprng text not null,
	nazwa text not null,
	x_informdodatkowa text,
	x_aktualnoscA date not null
);

create table ot_ciek (
id serial primary key,
nazwa text not null,
dlugosc float not null);

-- ot_ptwp_a

create table ot_ptwp_a (
	id serial primary key,
	idmphp text,
	poziomwody real,
	rodzaj text not null references ot_rodzajobszaruwody(id),
	-- atrybuty z ot_pokrycie terenu
	geometria geometry(Polygon,2180) not null,
	--atrybuty z ot_obiektropograficzny
	idiip integer not null references bt_identyfikator(id),
	czyobiektbdoo boolean  not null,
	x_kod text  not null,
	x_katdoklgeom text not null references ot_katdokladnosci(id),
	x_doklgeom float,
	x_zrodlodanychg text  not null not null references ot_zrodlodanych(id),
	x_zrodlodanycha text  not null not null references ot_zrodlodanych(id),
	x_rodzajreprgeom text  not null references ot_rodzajreprgeom(id),
	x_uwagi text,
	x_uzytkownik text not null,
	x_aktualnoscg date not null,
	x_aktualnosca date not null,
	x_cyklzycia date not null,
	x_datautworzenia date not null,
	x_informdodatkowa text,
	--constaint
	ciek2 integer references ot_ciek(id),
	zbiornikwodny1 integer references ot_zbiornikwodny(id)
);

-- slowniki potrzebne do ot_swrs_l
create table ot_rodzajrzeki (
	id text primary key,
	nazwa text
);

insert into ot_rodzajrzeki values ('Rz','rzeka');
insert into ot_rodzajrzeki values ('St','strumienPotokLubStruga');
insert into ot_rodzajrzeki values ('RS','rzekaStrumienPotokLubStruga');

create table ot_przebiegcieku (
	id text primary key,
	nazwa text
);

insert into ot_przebiegcieku values ('Cgl','ciekGlowny');
insert into ot_przebiegcieku values ('Rbc','ramieBoczne');

create table ot_statuseksploatacji (
	id text primary key,
	nazwa text
);

insert into ot_statuseksploatacji values ('NZ','niezeglowny');
insert into ot_statuseksploatacji values ('Z','zeglowny');

-- ot_swrs_l

create table ot_swrs_l (
	id serial primary key,
	okresowosc boolean not null,
	przebieg text not null references ot_przebiegcieku(id),
	rodzaj text not null references ot_rodzajrzeki(id),
	statuseksploatacji text references ot_statuseksploatacji(id),
	-- atrybuty z ot_siecwodna
	idmphp text,
	geometria geometry(Multilinestring,2180),
	ciek1 integer references ot_ciek(id),
	-- atrybuty z ot_obiekttopograficzny 
	idiip integer not null references  bt_identyfikator(id),
	czyobiektbdoo boolean  not null,
	x_kod text  not null,
	x_katdoklgeom text  not null references ot_katdokladnosci(id),
	x_doklgeom float, 
	x_zrodlodanychg text  not null references ot_zrodlodanych(id),
	x_zrodlodanycha text  not null references ot_zrodlodanych(id),
	x_rodzajreprgeom text  not null references ot_rodzajreprgeom(id),
	x_uwagi text, 
	x_uzytkownik text not null,
	x_aktualnoscg date not null,
	x_aktualnosca date not null,
	x_cyklzycia date not null,
	x_datautworzenia date not null,
	x_informdodatkowa text --moze byc null
);

-- Do tabel należy dodatkowo wprowadzić atrybut data_zmiany (date)

alter table ot_tcpk_a
add column data_zmiany date;

alter table ot_ptwp_a
add column data_zmiany date;

alter table ot_swrs_l
add column data_zmiany date;

-- indexy przestrzenne
create index idx_tcpka on ot_tcpk_a(geometria);
create index idx_ptwpa on ot_ptwp_a(geometria);
create index idx_swrs_l on ot_swrs_l(geometria);


-- WIDOKI ZMATERIALIZOWANE

create materialized view mv_ot_tcpk_a as
select a.id,a.nazwa,a.geometria,
		kd.nazwa as nazwa_katdokl, 
		zdg.nazwa as nazwa_zrodlodanych_g,
		zda.nazwa as nazwa_zrodlodanych_a,
		rg.nazwa as nazwa_rodzajreprgeom
from ot_tcpk_a as a
left join ot_katdokladnosci as kd on a.x_katdoklgeom = kd.id
left join ot_zrodlodanych as zdg on a.x_zrodlodanychg = zdg.id
left join ot_zrodlodanych as zda on a.x_zrodlodanycha = zda.id
left join ot_rodzajreprgeom as rg on a.x_rodzajreprgeom = rg.id
with data;

create unique index mv_ot_tcpk_a_idx
on mv_ot_tcpk_a using btree(id);

create index mv_ot_tcpk_a_sdx
on mv_ot_tcpk_a using gist(geometria);



create materialized view mv_ot_ptwp_a as
select
    a.id,
    a.poziomwody,
    a.rodzaj,
    a.geometria,
    kd.nazwa as nazwa_katdokl, 
    zdg.nazwa as nazwa_zrodlodanych_g, 
    zda.nazwa as nazwa_zrodlodanych_a,
    rg.nazwa as nazwa_rodzajreprgeom,
    rw.nazwa as nazwa_rodzajobszaruwody
from 
    ot_ptwp_a as a
left join ot_katdokladnosci as kd on a.x_katdoklgeom = kd.id
left join ot_zrodlodanych as zdg on a.x_zrodlodanychg = zdg.id
left join ot_zrodlodanych as zda on a.x_zrodlodanycha = zda.id
left join ot_rodzajreprgeom as rg on a.x_rodzajreprgeom = rg.id
left join ot_rodzajobszaruwody as rw on a.rodzaj = rw.id
with data;

create unique index mv_ot_ptwp_a_idx
on mv_ot_ptwp_a using btree(id);

create index mv_ot_ptwp_a_sdx
on mv_ot_ptwp_a using gist(geometria);


create materialized view mv_ot_swrs_l as
select l.id,l.okresowosc,l.przebieg,l.rodzaj,
		l.statuseksploatacji,l.geometria,
		kd.nazwa as nazwa_katdokl, 
		zdg.nazwa as nazwa_zrodlodanych_g, 
		zda.nazwa as nazwa_zrodlodanych_a, 
		rg.nazwa as nazwa_rodzajreprgeom,
		pc.nazwa as nazwa_przebiegcieku,
		rr.nazwa as nazwa_rodzajrzeki,
		se.nazwa as nazwa_statuseksploatacji
from ot_swrs_l as l
left join ot_katdokladnosci as kd on l.x_katdoklgeom = kd.id
left join ot_zrodlodanych as zdg on l.x_zrodlodanychg = zdg.id
left join ot_zrodlodanych as zda on l.x_zrodlodanycha = zda.id
left join ot_rodzajreprgeom as rg on l.x_rodzajreprgeom = rg.id
left join ot_przebiegcieku as pc on l.przebieg = pc.id 
left join ot_rodzajrzeki as rr on l.rodzaj = rr.id
left join ot_statuseksploatacji as se on l.statuseksploatacji = se.id
with data;

create unique index mv_ot_swrs_l_idx
on mv_ot_swrs_l using btree(id);

create index mv_ot_swrs_l_sdx
on mv_ot_swrs_l using gist(geometria);


-- trigger
--Po wykryciu próby aktualizacji rekordów w tabelach ot_tcpk_a, ot_ptwp_a, ot_swrs_l sprawdzą, czy
--centroid geometrii po aktualizacji zmienił swoje położenie względem pierwtonego położenia. Jeżeli
--taka zmiana zaszła do atrybutu data_zmiany należy wprowadzić aktualną datę.

create function fun_data_zmiany()
returns trigger as $$
declare
	old_centroid geometry;
	new_centroid geometry;
begin
	old_centroid:= st_centroid(old.geometria);
	new_centroid:= st_centroid(new.geometria);
	
	if old_centroid is distinct from new_centroid then
		new.data_zmiany:= current_date;
	end if;
	
	return new;
end;
$$
language plpgsql volatile
cost 100;

create trigger trg_update_tcpk_a
before update on ot_tcpk_a
for each row
execute procedure fun_data_zmiany();

create trigger trg_update_ptwp_a
before update on ot_ptwp_a
for each row
execute procedure fun_data_zmiany();

create trigger trg_update_swrs_l
before update on ot_swrs_l
for each row
execute procedure fun_data_zmiany();


--funkcja

create function fun_parkikrajobrazowe (p_numercrfop text) returns text as
$$
declare
	rec_park record;
	wody_stojace double precision;
	wody_plynace double precision;
	powierzchnia double precision;
	prc_wody double precision;
	prc_lasu double precision;
	
begin
	--Utworzy nową tabelę o nazwie parki_krajobrazowe(id(serial)PK, idnatura(text),
	--nazwa(text), procentwody(double), procentlasu(double), dlugoscrzek(double))
	drop table if exists parki_krajobrazowe;
	create table parki_krajobrazowe (id serial primary key, idnatura text,
									nazwa text, procentwody double precision, procentlasu double precision,dlugoscrzek double precision);
	
	--Wybierze obiekt z tabeli ot_tcpk_a (parki krajobrazowe), którego wartość
	--atrybutu numerCRFOP jest podana jako parametr wejściowy funkcji
	select * into rec_park
	from ot_tcpk_a
	where ot_tcpk_a.idksoch = p_numercrfop;
	
	wody_stojace:= 0;
	wody_plynace:= 0;
	powierzchnia:= st_area(rec_park.geometria);
	
	--przetnie geometrie obiektów z tabeli ot_ptwp_a i określi sumaryczną powierzchnię obiektów
	--powstałych po przecięciu, znajdujących się wewnątrz badanego obiektu z pkt. 2. Tę sumę
	--powierzchni zapisze w zmiennej WODY_STOJACE
	select sum(st_area(st_intersection(rec_park.geometria,ptwp.geometria))) into wody_stojace
	from ot_ptwp_a as ptwp
	where st_intersects(rec_park.geometria, ptwp.geometria);
	
	--przetnie geometrie obiektów z tabeli ot_swrm_l i określi sumaryczną długość obiektów
	--powstałych po przecięciu, znajdujących się wewnątrz badanego obiektu z pkt. 2. Tę sumę
	--długości zapisze w zmiennej WODY_PLYNACE
	select sum(st_length(st_intersection(rec_park.geometria,swrs.geometria))) into wody_plynace
	from ot_swrs_l as swrs
	where st_intersects(rec_park.geometria,swrs.geometria);
	
	--wprowadzi do tabeli parki_krajobrazowe rekord zawierający informacje: o numerCRFOP
	--obiektu z ot_tcpk_a, nazwie tego obiektu, powierzchni zajętej przez wody stojące (ze zmiennej
	--WODY_STOJACE), długości cieków znajdujących się na jego terenie (ze zmiennej
	--WODY_PLYNACE).
	
	--obliczenie procentow
	if powierzchnia > 0 then
		prc_wody:= (wody_stojace / powierzchnia) * 100;
		prc_lasu:= ((powierzchnia - wody_stojace) / powierzchnia) *100;
	else
		prc_wody:=0;
		prc_lasu:=0;
	end if;
	
	insert into parki_krajobrazowe(idnatura,nazwa,procentwody,procentlasu,dlugoscrzek)
	values (rec_park.idksoch, rec_park.nazwa, prc_wody,prc_lasu, wody_plynace);


return 'done';
end;
$$
language plpgsql volatile
cost 1000;

