USE devopsdb;

CREATE TABLE dbversion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    version VARCHAR(50) NOT NULL
);

INSERT INTO dbversion (version) VALUES ('1.0');
