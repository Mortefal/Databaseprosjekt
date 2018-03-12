CREATE TABLE Øvelsesgruppe (
    GruppeID INT NOT NULL,
    Fokusgruppenavn VARCHAR(30),
    Muskelgruppe VARCHAR(50),
    PRIMARY KEY (GruppeID)
);
CREATE TABLE Apparat(
	ApparatID INT NOT NULL,
    Navn VARCHAR(50),
    Bruksanvisning tinytext,
    primary key(ApparatID));
CREATE TABLE Øvelse(
	ØvelsesID INT NOT NULL,
    Navn VARCHAR(50),
    primary key(ØvelsesID));
CREATE TABLE Treningsøkt (
	TreningsøktID INT NOT NULL,
    Dato DATE NOT NULL,
    Tidspunkt TIME,
    Varighet TIME,
    PersonligForm INT,
    Prestasjon INT,
    ØvelsesID INT NOT NULL,
    primary key(TreningsøktID),
    CONSTRAINT fk_ØvelsesID_treningsøkt FOREIGN KEY(ØvelsesID)
		REFERENCES Øvelse(ØvelsesID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );
CREATE TABLE PåApparat(
	Navn VARCHAR(75) NOT NULL,
    Antall_kilo INT,
    Antall_sett INT,
    ØvelsesID INT NOT NULL,
    ApparatID INT NOT NULL,
    CONSTRAINT fk_ØvelsesID FOREIGN KEY(ØvelsesID)
		REFERENCES Øvelse(ØvelsesID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_apparatID FOREIGN KEY(ApparatID)
		REFERENCES Apparat(ApparatID)
		ON DELETE CASCADE
        ON UPDATE CASCADE
	);
CREATE TABLE UtenApprat(
	Navn VARCHAR(50),
    Beskrivelse tinytext,
    ØvelsesID INT NOT NULL,
    CONSTRAINT fk_ØvelsesID_utenApparat FOREIGN KEY(ØvelsesID)
		REFERENCES Øvelse(ØvelsesID)
        
		ON DELETE CASCADE
        ON UPDATE CASCADE
        );
CREATE TABLE Notat(
	TreningsøktID INT NOT NULL,
    Treningsformål VARCHAR(75),
    Treningsopplevelse tinytext,
    CONSTRAINT fk_TreningsøktID FOREIGN KEY(TreningsøktID)
		REFERENCES Treningsøkt(TreningsøktID)
        );
CREATE TABLE Øvelse_I_Gruppe(
	ØvelsesID INT NOT NULL,
    GruppeID INT NOT NULL,
    CONSTRAINT fk_ØvelsesID_ØIG FOREIGN KEY(ØvelsesID)
		REFERENCES Øvelse(ØvelsesID),
	CONSTRAINT fk_GruppeID_ØIG FOREIGN KEY(GruppeID)
		REFERENCES Øvelsesgruppe(GruppeID)
        );
CREATE TABLE Øvelser_I_Treningsøkt(
	TreningsøktID INT NOT NULL,
    ØvelsesID INT NOT NULL,
    CONSTRAINT fk_TreningsID_øvelser_i_treningsøkt FOREIGN KEY(TreningsøktID)
		REFERENCES Treningsøkt(TreningsøktID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_ØvelsesID_øvelser_i_treningsøkt FOREIGN KEY(ØvelsesID)
		REFERENCES Øvelse(ØvelsesID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
        );
CREATE TABLE Pulsmåling(
	PersonID int not null,
    Hvilepuls int,
    Maxpuls int,
    Gjennomsnittspuls int,
    TreningsøktID int not null,
    ØvelsesID int not null,
    primary key(PersonID),
    CONSTRAINT fk_TreningsøktID_pulsmåling foreign key(TreningsøktID)
		references treningsøkt(TreningsøktID)
        on delete cascade
        on update cascade,
	constraint fk_ØvelsesID_pulsmåling foreign key(ØvelsesID)
		references Øvelse(ØvelsesID)
        on delete cascade
        on update cascade
	);
create table PulsmålingTreningsøkt(
	PersonID int not null,
    TreningsøktID int not null,
    constraint fk_treningsøktID_puls_treningsøkt foreign key(TreningsøktID)
		references Treningsøkt(TreningsøktID)
        on delete cascade
        on update cascade,
	constraint fk_PersonID_puls_treningsøkt foreign key(PersonID)
		references Pulsmåling(PersonID)
        on delete cascade
        on update cascade
	);
create table PulsmålingØvelse(
	PersonID int not null,
    ØvelsesID int not null,
    constraint fk_øvelsesID_puls_øvelse foreign key(ØvelsesID)
		references Øvelse(ØvelsesID)
        on delete cascade
        on update cascade,
	constraint fk_PersonID_puls_øvelse foreign key(PersonID)
		references pulsmåling(PersonID)
        on delete cascade
        on update cascade
        );