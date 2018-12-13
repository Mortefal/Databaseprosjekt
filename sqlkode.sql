CREATE TABLE �velsesgruppe (
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
CREATE TABLE �velse(
	�velsesID INT NOT NULL,
    Navn VARCHAR(50),
    primary key(�velsesID));
CREATE TABLE Trenings�kt (
	Trenings�ktID INT NOT NULL,
    Dato DATE NOT NULL,
    Tidspunkt TIME,
    Varighet TIME,
    PersonligForm INT,
    Prestasjon INT,
    �velsesID INT NOT NULL,
    primary key(Trenings�ktID),
    CONSTRAINT fk_�velsesID_trenings�kt FOREIGN KEY(�velsesID)
		REFERENCES �velse(�velsesID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );
CREATE TABLE P�Apparat(
	Navn VARCHAR(75) NOT NULL,
    Antall_kilo INT,
    Antall_sett INT,
    �velsesID INT NOT NULL,
    ApparatID INT NOT NULL,
    CONSTRAINT fk_�velsesID FOREIGN KEY(�velsesID)
		REFERENCES �velse(�velsesID)
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
    �velsesID INT NOT NULL,
    CONSTRAINT fk_�velsesID_utenApparat FOREIGN KEY(�velsesID)
		REFERENCES �velse(�velsesID)
        
		ON DELETE CASCADE
        ON UPDATE CASCADE
        );
CREATE TABLE Notat(
	Trenings�ktID INT NOT NULL,
    Treningsform�l VARCHAR(75),
    Treningsopplevelse tinytext,
    CONSTRAINT fk_Trenings�ktID FOREIGN KEY(Trenings�ktID)
		REFERENCES Trenings�kt(Trenings�ktID)
        );
CREATE TABLE �velse_I_Gruppe(
	�velsesID INT NOT NULL,
    GruppeID INT NOT NULL,
    CONSTRAINT fk_�velsesID_�IG FOREIGN KEY(�velsesID)
		REFERENCES �velse(�velsesID),
	CONSTRAINT fk_GruppeID_�IG FOREIGN KEY(GruppeID)
		REFERENCES �velsesgruppe(GruppeID)
        );
CREATE TABLE �velser_I_Trenings�kt(
	Trenings�ktID INT NOT NULL,
    �velsesID INT NOT NULL,
    CONSTRAINT fk_TreningsID_�velser_i_trenings�kt FOREIGN KEY(Trenings�ktID)
		REFERENCES Trenings�kt(Trenings�ktID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_�velsesID_�velser_i_trenings�kt FOREIGN KEY(�velsesID)
		REFERENCES �velse(�velsesID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
        );
CREATE TABLE Pulsm�ling(
	PersonID int not null,
    Hvilepuls int,
    Maxpuls int,
    Gjennomsnittspuls int,
    Trenings�ktID int not null,
    �velsesID int not null,
    primary key(PersonID),
    CONSTRAINT fk_Trenings�ktID_pulsm�ling foreign key(Trenings�ktID)
		references trenings�kt(Trenings�ktID)
        on delete cascade
        on update cascade,
	constraint fk_�velsesID_pulsm�ling foreign key(�velsesID)
		references �velse(�velsesID)
        on delete cascade
        on update cascade
	);
create table Pulsm�lingTrenings�kt(
	PersonID int not null,
    Trenings�ktID int not null,
    constraint fk_trenings�ktID_puls_trenings�kt foreign key(Trenings�ktID)
		references Trenings�kt(Trenings�ktID)
        on delete cascade
        on update cascade,
	constraint fk_PersonID_puls_trenings�kt foreign key(PersonID)
		references Pulsm�ling(PersonID)
        on delete cascade
        on update cascade
	);
create table Pulsm�ling�velse(
	PersonID int not null,
    �velsesID int not null,
    constraint fk_�velsesID_puls_�velse foreign key(�velsesID)
		references �velse(�velsesID)
        on delete cascade
        on update cascade,
	constraint fk_PersonID_puls_�velse foreign key(PersonID)
		references pulsm�ling(PersonID)
        on delete cascade
        on update cascade
        );