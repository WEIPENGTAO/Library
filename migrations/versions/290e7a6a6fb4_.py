"""empty message

Revision ID: 290e7a6a6fb4
Revises: c071e023548a
Create Date: 2023-12-30 11:02:19.514981

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '290e7a6a6fb4'
down_revision = 'c071e023548a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('reader',
    sa.Column('reader_id', sa.String(length=20), nullable=False),
    sa.Column('name', sa.String(length=20), nullable=True),
    sa.Column('password', sa.String(length=20), nullable=False),
    sa.Column('email', sa.String(length=45), nullable=True),
    sa.Column('phone', sa.String(length=20), nullable=True),
    sa.Column('sex', sa.String(length=1), nullable=True),
    sa.Column('fine', sa.DECIMAL(precision=6, scale=2), nullable=False),
    sa.Column('borrow_num', sa.Integer(), nullable=False, comment='一名读者最多只能借阅十本图书，且每本图书最多只能借两个月'),
    sa.PrimaryKeyConstraint('reader_id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('reader')
    # ### end Alembic commands ###
