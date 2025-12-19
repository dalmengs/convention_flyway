-- =========================================================
-- Add chatroom_seq to chat_group table
-- =========================================================

-- Add chatroom_seq column
ALTER TABLE chat_group
ADD COLUMN chatroom_seq BIGINT NOT NULL;

-- Add foreign key constraint referencing chatroom.seq
ALTER TABLE chat_group
ADD CONSTRAINT fk_chat_group_chatroom_seq
    FOREIGN KEY (chatroom_seq)
    REFERENCES chatroom(seq)
    ON DELETE CASCADE;

-- Add index for chatroom_seq
CREATE INDEX idx_chat_group_chatroom_seq ON chat_group(chatroom_seq);

