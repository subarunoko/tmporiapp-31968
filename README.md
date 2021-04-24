## テーブル設計

## users テーブル

| Column              | Type      | Options                   |
| --------------------| --------- | ------------------------- |
| nickname            | string    | null: false               |
| email               | string    | null: false, unique: true |
| encrypted_password  | string    | null: false               |


## articles テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| title            | string       | null: false                    |
| body             | text         | null: false                    |
| user             | references   | null: false, foreign_key: true |

## Association
- belongs_to :user


## likes テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| user             | references   | null: false, foreign_key: true |
| article          | references   | null: false, foreign_key: true |

## Association
  belongs_to :user
  belongs_to :article


## relationships テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| user             | references   | null: false, foreign_key: true |
| follower         | references   | null: false, foreign_key: true |

## Association
  belongs_to :user
  belongs_to :follower, class_name: 'User'



## 工事中