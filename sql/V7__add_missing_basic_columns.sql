-- =========================================================
-- Add missing basic columns (id, updated_at) to tables
-- =========================================================

-- Add id to user_profile_metadata
ALTER TABLE user_profile_metadata
ADD COLUMN id VARCHAR(26) NOT NULL UNIQUE;

-- Add id and updated_at to chatroom_character
ALTER TABLE chatroom_character
ADD COLUMN id VARCHAR(26) NOT NULL UNIQUE;

ALTER TABLE chatroom_character
ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

-- Add id to chat_content_group
ALTER TABLE chat_content_group
ADD COLUMN id VARCHAR(26) NOT NULL UNIQUE;

-- Add id to chat_content
ALTER TABLE chat_content
ADD COLUMN id VARCHAR(26) NOT NULL UNIQUE;

