CREATE TABLE IF NOT EXISTS my_table_tdc (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(255)    NOT NULL,
    birthday    TIMESTAMPTZ,
    address     VARCHAR(500)
);

INSERT INTO my_table_tdc (name, birthday, address) VALUES
    ('Nguyen Van An',      '1990-03-15 00:00:00+07', '12 Ly Thuong Kiet, Ha Noi'),
    ('Tran Thi Bich',      '1985-07-22 00:00:00+07', '45 Nguyen Hue, Ho Chi Minh'),
    ('Le Quoc Cuong',      '1992-11-08 00:00:00+07', '78 Tran Phu, Da Nang'),
    ('Pham Thi Dung',      '1988-01-30 00:00:00+07', '23 Hung Vuong, Can Tho'),
    ('Hoang Van Em',       '1995-05-17 00:00:00+07', '56 Le Loi, Hue'),
    ('Vu Thi Phuong',      '1993-09-04 00:00:00+07', '89 Phan Chu Trinh, Hai Phong'),
    ('Do Minh Giang',      '1987-12-25 00:00:00+07', '34 Dinh Tien Hoang, Nha Trang'),
    ('Bui Thi Hoa',        '1991-06-11 00:00:00+07', '67 Tran Hung Dao, Vung Tau'),
    ('Dang Van Khoa',      '1996-02-28 00:00:00+07', '11 Nguyen Trai, Bien Hoa'),
    ('Nguyen Thi Lan',     '1989-08-19 00:00:00+07', '90 Le Duan, Buon Ma Thuot');
