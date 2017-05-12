# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "spanner_helper"

describe "Spanner Client", :types, :date, :spanner do
  let(:db) { spanner_client }
  let(:table_name) { "stuffs" }
  let(:table_types) { stuffs_table_types }

  it "writes and reads date" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, date: Date.parse("2017-01-01") }
    results = db.read table_name, [:id, :date], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, date: :DATE })
    results.rows.first.to_h.must_equal({ id: id, date: Date.parse("2017-01-01") })
  end

  it "writes and queries date" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, date: Date.parse("2017-01-01") }
    results = db.execute "SELECT id, date FROM #{table_name} WHERE id = @id", params: { id: id }

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, date: :DATE })
    results.rows.first.to_h.must_equal({ id: id, date: Date.parse("2017-01-01") })
  end

  it "writes and reads NULL date" do
    skip
    id = SecureRandom.int64
    db.upsert table_name, { id: id, date: nil }, types: table_types
    results = db.read table_name, [:id, :date], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, date: :DATE })
    results.rows.first.to_h.must_equal({ id: id, date: nil })
  end

  it "writes and reads array of date" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: [Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] }
    results = db.read table_name, [:id, :dates], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: [Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] })
  end

  it "writes and queries array of date" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: [Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] }
    results = db.execute "SELECT id, dates FROM #{table_name} WHERE id = @id", params: { id: id }

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: [Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] })
  end

  it "writes and reads array of date with NULL" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: [nil, Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] }
    results = db.read table_name, [:id, :dates], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: [nil, Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] })
  end

  it "writes and queries array of date with NULL" do
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: [nil, Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] }
    results = db.execute "SELECT id, dates FROM #{table_name} WHERE id = @id", params: { id: id }

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: [nil, Date.parse("2016-12-30"), Date.parse("2016-12-31"), Date.parse("2017-01-01")] })
  end

  it "writes and reads empty array of date" do
    skip
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: [] }, types: table_types
    results = db.read table_name, [:id, :dates], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: [] })
  end

  it "writes and reads NULL array of date" do
    skip
    id = SecureRandom.int64
    db.upsert table_name, { id: id, dates: nil }, types: table_types
    results = db.read table_name, [:id, :dates], keys: id

    results.must_be_kind_of Google::Cloud::Spanner::Results
    results.fields.to_h.must_equal({ id: :INT64, dates: [:DATE] })
    results.rows.first.to_h.must_equal({ id: id, dates: nil })
  end
end
