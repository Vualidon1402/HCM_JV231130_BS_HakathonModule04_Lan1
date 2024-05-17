**Tạo CSDL Test2
CREATE DATABASE Test2
COLLATE utf8_unicode_ci;

USE Test2;

**Tạo bảng
CREATE TABLE `Students` (
  `StudentID` int(4) NOT NULL,
  `StudentName` varchar(50) NOT NULL,
  `Age` int(4) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`StudentID`)
);

CREATE TABLE `Subjects` (
  `SubjectID` int(4) NOT NULL,
  `SubjectName` varchar(50) NOT NULL,
  PRIMARY KEY (`SubjectID`)
);

CREATE TABLE `Classes` (
  `ClassID` int(4) NOT NULL,
  `ClassName` varchar(50) NOT NULL,
  PRIMARY KEY (`ClassID`)
);

CREATE TABLE `ClassStudent` (
  `StudentID` int(4) NOT NULL,
  `ClassID` int(4) NOT NULL,
  PRIMARY KEY (`StudentID`, `ClassID`),
);

CREATE TABLE `Marks` (
  `Mark` int(4) NOT NULL,
  `SubjectID` int(4) NOT NULL,
  `StudentID` int(4) NOT NULL,
  PRIMARY KEY (`SubjectID`, `StudentID`),
);

**Liên kết bảng
ALTER TABLE `ClassStudent`
ADD FOREIGN KEY (`StudentID`) REFERENCES `Students` (`StudentID`),
ADD FOREIGN KEY (`ClassID`) REFERENCES `Classes` (`ClassID`);

ALTER TABLE `Marks`
ADD FOREIGN KEY (`SubjectID`) REFERENCES `Subjects` (`SubjectID`),
ADD FOREIGN KEY (`StudentID`) REFERENCES `Students` (`StudentID`);

**Thêm dữ liệu
INSERT INTO `Students` (`StudentID`, `StudentName`, `Age`, `Email`) VALUES
(1,'Nguyen Quang An', 18, 'an@yahoo.com'),
(2,'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
(3, 'Nguyen Van Quyen', 19, 'quyen'),
(4, 'Pham Thanh Binh', 25, 'binh@com'),
(5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');

INSERT INTO `Classes` (`ClassID`, `ClassName`) VALUES
(1, 'C0706L'),
(2, 'C0708G');

INSERT INTO `ClassStudent` (`StudentID`, `ClassID`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2);

INSERT INTO `subjects` (`SubjectID`, `SubjectName`) VALUES
(1, 'SQL'),
(2, 'Java'),
(3, 'C'),
(4, 'Visual Basic');

INSERT INTO `Marks` (`Mark`, `SubjectID`, `StudentID`) VALUES
(8, 1, 1),
(4, 2, 1),
(9, 1, 5),
(7, 1, 3),
(3, 1, 4),
(5, 2, 5),
(8, 3, 3),
(1, 3, 5),
(3, 2, 4);

**Câu truy vấn
1. Hiển thị danh sách tất cả học viên
SELECT * FROM `Students`;

2. Hiển thị danh sách tất cả môn học
SELECT * FROM `Subjects`;

3. Tính điểm trung bình:
SELECT StudentID, AVG(Mark) AS AverageMark
FROM `Marks`
GROUP BY StudentID;

4. Hiển thị môn học nào có học sinh thi được điểm cao nhất
SELECT s.SubjectID, s.SubjectName, m.HighestMark
FROM Subjects s
JOIN (
    SELECT SubjectID, MAX(Mark) AS HighestMark
    FROM Marks
    GROUP BY SubjectID
) m ON s.SubjectID = m.SubjectID
ORDER BY m.HighestMark DESC
LIMIT 1;

5. Đánh số thứ tự của điểm theo chiều giảm:
SELECT 
    StudentID, 
    SubjectID, 
    Mark,
    RANK() OVER (ORDER BY Mark DESC) AS RankMarks
FROM 
    Marks;

6. Thay đổi kiểu dữ liệu của cột SubjectName trong bảng Subjects thành varchar(max)
ALTER TABLE `Subjects`
MODIFY `SubjectName` VARCHAR(255);

7. Cập nhật thêm dòng chữ "Day la mon hoc" vào trước các bản ghi trên cột SubjectName trong bảng Subjects
UPDATE `Subjects`
SET `SubjectName` = CONCAT('Day la mon hoc ', `SubjectName`);

8. Viết Check Constraint để kiểm tra độ tuổi nhập vào trong bảng Student yêu cầu Age >15 và Age < 50:
ALTER TABLE `Students`
ADD CONSTRAINT chk_Age
CHECK (Age > 15 AND Age < 50);

9. Loại bỏ tất cả quan hệ giữa các bảng:
ALTER TABLE `Marks` DROP FOREIGN KEY `marks_ibfk_1`;
ALTER TABLE `Marks` DROP FOREIGN KEY `marks_ibfk_2`;
ALTER TABLE `ClassStudent` DROP FOREIGN KEY `classstudent_ibfk_1`;
ALTER TABLE `ClassStudent` DROP FOREIGN KEY `classstudent_ibfk_2`;

10. Xóa học viên có StudentID là 1:
DELETE FROM `Students`
WHERE `StudentID` = 1;

11. Trong bảng Student thêm cột Status có kiểu dữ liệu là Bit và Default là 1:
ALTER TABLE `Students`
ADD `Status` BIT DEFAULT 1;

12. Cập nhật giá trị trong bảng Student thành 0
UPDATE `Students`
SET `Status` = 0;



