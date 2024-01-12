"""empty message

Revision ID: 5b2d1863aea9
Revises: 510efb3d1ba2
Create Date: 2024-01-12 15:23:19.043758

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '5b2d1863aea9'
down_revision = '510efb3d1ba2'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('reserve', schema=None) as batch_op:
        batch_op.add_column(sa.Column('ISBN', sa.String(length=100), nullable=True))
        batch_op.drop_constraint('reserve_ibfk_2', type_='foreignkey')
        batch_op.create_foreign_key(None, 'booktable', ['ISBN'], ['ISBN'], onupdate='CASCADE', ondelete='CASCADE')
        batch_op.drop_column('booktable_ISBN')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('reserve', schema=None) as batch_op:
        batch_op.add_column(sa.Column('booktable_ISBN', mysql.VARCHAR(length=100), nullable=True))
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.create_foreign_key('reserve_ibfk_2', 'booktable', ['booktable_ISBN'], ['ISBN'], onupdate='CASCADE', ondelete='CASCADE')
        batch_op.drop_column('ISBN')

    # ### end Alembic commands ###
