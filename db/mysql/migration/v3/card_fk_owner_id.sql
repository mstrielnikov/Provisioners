ALTER TABLE card
ADD CONSTRAINT fk_owner_id FOREIGN KEY (user_id) REFERENCES owner(id);

