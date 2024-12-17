program MasalahKesehatan;
uses crt;
type
  TUser = record
    Nama: string;
    Berat: real;
    Tinggi: real;
    Usia: integer;
    JenisKelamin: char;
    LingkarPinggang: real;
    LingkarPanggul: real;
    Aktivitas: integer;
  end;

function HitungBMI(Berat, Tinggi: real): real;
begin
  HitungBMI := Berat / sqr(Tinggi / 100);
end;

procedure TampilkanKategoriBMI(BMI: real);
begin
  if BMI < 18.5 then
    writeln('Kategori: Kurus')
  else if (BMI >= 18.5) and (BMI < 25) then
    writeln('Kategori: Normal')
  else if (BMI >= 25) and (BMI < 30) then
    writeln('Kategori: Overweight')
  else
    writeln('Kategori: Obesitas');
end;

function HitungKalori(Berat, Tinggi: real; Usia: integer; JenisKelamin: char; Aktivitas: integer): real;
var
  BMR: real;
begin
  if (JenisKelamin = 'L') or (JenisKelamin = 'l') then
    BMR := 66 + (13.7 * Berat) + (5 * Tinggi) - (6.8 * Usia)
  else
    BMR := 655 + (9.6 * Berat) + (1.8 * Tinggi) - (4.7 * Usia);

  case Aktivitas of
    1: HitungKalori := BMR * 1.2;    // Aktivitas Sedentary
    2: HitungKalori := BMR * 1.375; // Aktivitas Ringan
    3: HitungKalori := BMR * 1.55;  // Aktivitas Sedang
    4: HitungKalori := BMR * 1.725; // Aktivitas Berat
  else
    HitungKalori := BMR; // Default
  end;
end;

function HitungHidrasi(Berat: real; Aktivitas: integer): real;
begin
  HitungHidrasi := 35 * Berat;
  if Aktivitas > 2 then
    HitungHidrasi := HitungHidrasi + (500 * (Aktivitas - 2));
end;

function HitungRasioPinggangPanggul(LingkarPinggang, LingkarPanggul: real): real;
begin
  HitungRasioPinggangPanggul := LingkarPinggang / LingkarPanggul;
end;

procedure TampilkanRisikoPenyakitJantung(Rasio: real; JenisKelamin: char);
begin
  if ((JenisKelamin = 'L') or (JenisKelamin = 'l')) and (Rasio > 0.9) then
    writeln('Risiko: Tinggi')
  else if ((JenisKelamin = 'P') or (JenisKelamin = 'p')) and (Rasio > 0.85) then
    writeln('Risiko: Tinggi')
  else
    writeln('Risiko: Rendah');
end;

procedure RekomendasiLatihan(VO2Max: real);
begin
  if VO2Max < 20 then
    writeln('Kebugaran: Sangat Buruk - Rekomendasi: Jalan kaki santai.')
  else if VO2Max < 30 then
    writeln('Kebugaran: Buruk - Rekomendasi: Jalan cepat dan jogging ringan.')
  else if VO2Max < 40 then
    writeln('Kebugaran: Rata-rata - Rekomendasi: Jogging dan renang.')
  else
    writeln('Kebugaran: Baik - Rekomendasi: Latihan intensitas tinggi (HIIT).');
end;

var
  User: TUser;
  Pilihan: integer;
  BMI, Kalori, Hidrasi, Rasio, VO2Max: real;
  Ulangi: char;

begin
  repeat
    clrscr;
    writeln('Program Masalah Kesehatan Fisik');
    writeln('--------------------------------');
    writeln('1. Hitung BMI dan Kategori');
    writeln('2. Hitung Kebutuhan Kalori Harian');
    writeln('3. Hitung Kebutuhan Cairan Harian');
    writeln('4. Hitung Rasio Pinggang-Panggul');
    writeln('5. Rekomendasi Latihan Berdasarkan VO2Max');
    writeln('0. Keluar');
    writeln('--------------------------------');
    write('Pilih menu (0-5): '); readln(Pilihan);

    case Pilihan of
      1: begin
           write('Masukkan berat badan (kg): '); readln(User.Berat);
           write('Masukkan tinggi badan (cm): '); readln(User.Tinggi);
           BMI := HitungBMI(User.Berat, User.Tinggi);
           writeln('BMI Anda: ', BMI:0:2);
           TampilkanKategoriBMI(BMI);
         end;

      2: begin
           write('Masukkan berat badan (kg): '); readln(User.Berat);
           write('Masukkan tinggi badan (cm): '); readln(User.Tinggi);
           write('Masukkan usia: '); readln(User.Usia);
           write('Masukkan jenis kelamin (L/P): '); readln(User.JenisKelamin);
           write('Masukkan tingkat aktivitas (1-4): '); readln(User.Aktivitas);
           Kalori := HitungKalori(User.Berat, User.Tinggi, User.Usia, User.JenisKelamin, User.Aktivitas);
           writeln('Kebutuhan kalori harian Anda: ', Kalori:0:2, ' kkal');
         end;

      3: begin
           write('Masukkan berat badan (kg): '); readln(User.Berat);
           write('Masukkan tingkat aktivitas (1-4): '); readln(User.Aktivitas);
           Hidrasi := HitungHidrasi(User.Berat, User.Aktivitas);
           writeln('Kebutuhan cairan harian Anda: ', Hidrasi:0:2, ' ml');
         end;

      4: begin
           write('Masukkan lingkar pinggang (cm): '); readln(User.LingkarPinggang);
           write('Masukkan lingkar panggul (cm): '); readln(User.LingkarPanggul);
           write('Masukkan jenis kelamin (L/P): '); readln(User.JenisKelamin);
           Rasio := HitungRasioPinggangPanggul(User.LingkarPinggang, User.LingkarPanggul);
           writeln('Rasio pinggang-panggul Anda: ', Rasio:0:2);
           TampilkanRisikoPenyakitJantung(Rasio, User.JenisKelamin);
         end;

      5: begin
           write('Masukkan nilai VO2Max: '); readln(VO2Max);
           RekomendasiLatihan(VO2Max);
         end;

      0: writeln('Terima kasih telah menggunakan program ini.');
    else
      writeln('Pilihan tidak valid. Silakan coba lagi.');
    end;

    if Pilihan <> 0 then
    begin
      writeln; write('Ingin menggunakan program kembali? (Y/T): '); readln(Ulangi);
    end
    else
      Ulangi := 'T';

  until (Ulangi = 'T') or (Ulangi = 't');

  writeln('Program selesai. Semoga sehat selalu dan jaga kesehatan !');
end.
