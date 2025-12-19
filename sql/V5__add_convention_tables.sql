CREATE TABLE user_profile (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE user_profile_metadata (
    seq BIGSERIAL PRIMARY KEY,

    user_profile_seq BIGINT NOT NULL UNIQUE,

    name VARCHAR(255) NOT NULL,
    gender VARCHAR(20),
    birth DATE,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_user_profile_metadata_user_profile_seq
        FOREIGN KEY (user_profile_seq)
        REFERENCES user_profile(seq)
        ON DELETE CASCADE
);

CREATE TABLE chatroom (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    user_profile_seq BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_chatroom_user_profile_seq
        FOREIGN KEY (user_profile_seq)
        REFERENCES user_profile(seq)
        ON DELETE CASCADE
);

CREATE TABLE character (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    user_profile_seq BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    tagline VARCHAR(255),
    description TEXT,
    visibility VARCHAR(20) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_character_user_profile_seq
        FOREIGN KEY (user_profile_seq)
        REFERENCES user_profile(seq)
        ON DELETE RESTRICT
);

CREATE TABLE chatroom_character (
    seq BIGSERIAL PRIMARY KEY,

    chatroom_seq BIGINT NOT NULL,
    character_seq BIGINT NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_chatroom_character_chatroom_seq
        FOREIGN KEY (chatroom_seq)
        REFERENCES chatroom(seq)
        ON DELETE CASCADE,

    CONSTRAINT fk_chatroom_character_character_seq
        FOREIGN KEY (character_seq)
        REFERENCES character(seq)
        ON DELETE CASCADE,

    CONSTRAINT uq_chatroom_character UNIQUE (chatroom_seq, character_seq)
);


CREATE TABLE chat_group (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE chat_content_group (
    seq BIGSERIAL PRIMARY KEY,

    chat_group_seq BIGINT NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_chat_content_group_chat_group_seq
        FOREIGN KEY (chat_group_seq)
        REFERENCES chat_group(seq)
        ON DELETE CASCADE
);

CREATE TABLE chat_content (
    seq BIGSERIAL PRIMARY KEY,

    chat_content_group_seq BIGINT NOT NULL,

    message TEXT NOT NULL,
    is_character BOOLEAN NOT NULL,

    user_profile_seq BIGINT,
    character_seq BIGINT,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_chat_content_chat_content_group_seq
        FOREIGN KEY (chat_content_group_seq)
        REFERENCES chat_content_group(seq)
        ON DELETE CASCADE
);
