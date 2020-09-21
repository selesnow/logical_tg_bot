CREATE TABLE chat_state (
    chat_id BIGINT PRIMARY KEY
                   UNIQUE,
    state   TEXT
);
