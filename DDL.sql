CREATE DATABASE SIP_Oracle;

USE SIP_Oracle;

CREATE TABLE Calon_Siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    alamat TEXT NOT NULL,
    tanggal_lahir DATE NOT NULL,
    no_telepon VARCHAR(20),
    email VARCHAR(100),
    status_pembayaran VARCHAR(20) DEFAULT 'Belum Bayar'
);

CREATE TABLE Formulir_Pendaftaran (
    id_formulir INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    tanggal_pendaftaran DATE NOT NULL,
    status_formulir VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (id_siswa) REFERENCES Calon_Siswa(id_siswa)
);

CREATE TABLE Bank_Pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    tanggal_pembayaran DATE NOT NULL,
    jumlah DECIMAL(10, 2) NOT NULL,
    status_pembayaran VARCHAR(20) DEFAULT 'Belum Konfirmasi',
    FOREIGN KEY (id_siswa) REFERENCES Calon_Siswa(id_siswa)
);

CREATE TABLE Laporan_Pendaftaran (
    id_laporan INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    tanggal_laporan DATE NOT NULL,
    jenis_laporan VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_siswa) REFERENCES Calon_Siswa(id_siswa)
);

CREATE TABLE Kepala_Sekolah (
    id_kepala INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

CREATE TABLE Ketua_Yayasan (
    id_ketua INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

DELIMITER //
CREATE TRIGGER after_insert_formulir
AFTER INSERT ON Formulir_Pendaftaran
FOR EACH ROW
BEGIN
    INSERT INTO Laporan_Pendaftaran (id_siswa, tanggal_laporan, jenis_laporan)
    VALUES (NEW.id_siswa, NOW(), 'Pendaftaran Baru');
END//
DELIMITER ;